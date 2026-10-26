# Standalone regression checks; no database or Rails boot required.
require 'minitest/autorun'
require 'ostruct'
require 'tempfile'

class Numeric
  def seconds; self; end
end
class String
  def present?; !empty?; end
end
class ApplicationJob
  def self.retry_on(*); end
  def self.queue_as(*); end
end
ENV['JUDGE0_VERSION'] ||= 'test'
require_relative '../../app/jobs/isolate_job'

class CgroupsJobTest < Minitest::Test
  def setup
    @previous = ENV['JUDGE0_CGROUPS_VERSION']
    @job = IsolateJob.new
    @job.instance_variable_set(:@submission, OpenStruct.new(
      id: 12, enable_per_process_and_thread_time_limit: false,
      enable_per_process_and_thread_memory_limit: false))
    @job.instance_variable_set(:@cgroups, '--cg')
  end

  def teardown
    ENV['JUDGE0_CGROUPS_VERSION'] = @previous
  end

  def test_v1_timing_is_preserved
    ENV.delete('JUDGE0_CGROUPS_VERSION')
    assert_equal '--cg-timing', @job.send(:cgroup_timing_option)
    @job.submission.enable_per_process_and_thread_time_limit = true
    assert_equal '--no-cg-timing', @job.send(:cgroup_timing_option)
    @job.instance_variable_set(:@cgroups, '')
    assert_equal '', @job.send(:cgroup_timing_option)
  end

  def test_v2_omits_removed_flags
    ENV['JUDGE0_CGROUPS_VERSION'] = '2'
    assert_equal '', @job.send(:cgroup_timing_option)
  end

  def test_failed_init_never_cleans_an_unvalidated_path
    ENV.delete('JUDGE0_CGROUPS_VERSION')
    result = OpenStruct.new(success?: false)
    Open3.stub(:capture3, ['', 'init failed', result]) do
      assert_raises(RuntimeError) { @job.send(:initialize_workdir) }
    end
    Open3.stub(:capture3, ->(*) { flunk 'cleanup must not run' }) do
      @job.send(:cleanup)
    end
  end

  def test_success_with_unexpected_path_is_rejected
    ENV.delete('JUDGE0_CGROUPS_VERSION')
    Open3.stub(:capture3, ['/box', '', OpenStruct.new(success?: true)]) do
      assert_raises(RuntimeError) { @job.send(:initialize_workdir) }
    end
    refute @job.instance_variable_get(:@sandbox_initialized)
  end

  def test_cleanup_failure_releases_lock_and_does_not_retry_deletion
    file = Tempfile.new('judge0-slot-test')
    @job.instance_variable_set(:@box_lock, file)
    @job.instance_variable_set(:@sandbox_initialized, true)
    @job.instance_variable_set(:@box_id, 12)
    Open3.stub(:capture3, ['', 'cleanup failed', OpenStruct.new(success?: false)]) do
      assert_raises(RuntimeError) { @job.send(:cleanup) }
    end
    assert file.closed?
    Open3.stub(:capture3, ->(*) { flunk 'must not delete after releasing the slot' }) do
      @job.send(:cleanup, false)
    end
  ensure
    file.unlink if file
  end
end
