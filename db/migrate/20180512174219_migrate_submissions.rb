class MigrateSubmissions < ActiveRecord::Migration[5.2]
  def up
    add_reference :submissions, :source,           null: true
    add_reference :submissions, :test_suite,       null: true
    add_reference :submissions, :compile_output,   null: true
    add_reference :submissions, :internal_message, null: true

    i = 1
    n = Submission.count
    Submission.all.each do |s|
      Rails.logger.debug "Submission ID: #{s.id} (#{i}/#{n})"
      i += 1

      s.source = Document.find_or_create_with_content(decode(s[:source_code]))

      test_suite = Builder::TestSuite.find_or_create(
        [
          {
            input:  decode(s[:stdin]),
            output: decode(s[:expected_output])
          }
        ]
      )

      results = []
      test_suite.test_cases.each_with_index do |test_case, index|
        result = SubmissionResult.new(
          submission:     s,
          test_case:      test_case,
          stdout:         Document.find_or_create_with_content(decode(s[:stdout])),
          stderr:         Document.find_or_create_with_content(decode(s[:stderr])),
          compile_output: Document.find_or_create_with_content(decode(s[:compile_output])),
          time:           s.time,
          wall_time:      s.wall_time,
          memory:         s.memory,
          exit_code:      s.exit_code,
          exit_signal:    s.exit_signal,
          status_id:      s.status_id,
          index:          index,
          finished_at:    s.finished_at,
          created_at:     s.created_at
        )

        message_document = Document.find_or_create_with_content(s[:message])
        if result.status == Status.boxerr
          result.internal_message = message_document
        else
          result.sandbox_message = message_document
        end

        results << result
      end

      if s.status != Status.boxerr  &&
         s.status != Status.ce      &&
         s.status != Status.queue   &&
         s.status != Status.process
         s.status = Status.finished
      end

      s.compile_output = results.first.compile_output
      s.test_suite     = test_suite
      s.results        = results

      s.save!
    end

    remove_column :submissions, :source_code
    remove_column :submissions, :stdin
    remove_column :submissions, :stdout
    remove_column :submissions, :stderr
    remove_column :submissions, :expected_output
    remove_column :submissions, :compile_output
    remove_column :submissions, :message
    remove_column :submissions, :time
    remove_column :submissions, :wall_time
    remove_column :submissions, :memory
    remove_column :submissions, :exit_code
    remove_column :submissions, :exit_signal
  end

  def down
    # Ignorable.
  end

  private

  def decode(content)
    return nil unless content

    # Don't use Base64Service because it decodes differently than this method.
    # This is how we decoded content in the v1.0.0.
    Base64.decode64(content).force_encoding("UTF-8").encode
  end
end
