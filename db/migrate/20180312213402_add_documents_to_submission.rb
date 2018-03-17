class AddDocumentsToSubmission < ActiveRecord::Migration[5.1]
  def up
    add_column :submissions, :source_id, :integer
    add_column :submissions, :stdin_id, :integer
    add_column :submissions, :stdout_id, :integer
    add_column :submissions, :stderr_id, :integer
    add_column :submissions, :expected_output_id, :integer
    add_column :submissions, :compile_output_id, :integer
    add_column :submissions, :message_id, :integer

    i = 0
    n = Submission.count
    Submission.all.each do |s|
      i += 1
      puts "Submission #{s.id} (#{i}/#{n})"

      s.source_id = Document.find_or_create_with_content(decode(s[:source_code])).id if s[:source_code]
      s.stdin_id = Document.find_or_create_with_content(decode(s[:stdin])).id if s[:stdin]
      s.stdout_id = Document.find_or_create_with_content(decode(s[:stdout])).id if s[:stdout]
      s.stderr_id = Document.find_or_create_with_content(decode(s[:stderr])).id if s[:stderr]
      s.expected_output_id = Document.find_or_create_with_content(decode(s[:expected_output])).id if s[:expected_output]
      s.compile_output = Document.find_or_create_with_content(s[:compile_output]).id if s[:compile_output]
      s.message = Document.find_or_create_with_content(s[:message]).id if s[:message]

      s.save
    end

    remove_column :submissions, :source_code, :text
    remove_column :submissions, :stdin, :text
    remove_column :submissions, :stdout, :text
    remove_column :submissions, :stderr, :text
    remove_column :submissions, :expected_output, :text
    remove_column :submissions, :compile_output, :text
    remove_column :submissions, :message, :text
  end

  def down
  end

  private

  def decode(content)
    Base64.decode64(content).force_encoding("UTF-8").encode
  end
end
