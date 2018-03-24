class AddDocumentsToSubmission < ActiveRecord::Migration[5.1]
  def up
    add_column :submissions, :source_digest,          :string
    add_column :submissions, :stdin_digest,           :string
    add_column :submissions, :stdout_digest,          :string
    add_column :submissions, :stderr_digest,          :string
    add_column :submissions, :expected_output_digest, :string
    add_column :submissions, :compile_output_digest,  :string
    add_column :submissions, :message_digest,         :string

    i = 1
    n = Submission.count
    Submission.all.each do |s|
      puts "Submission ID: #{s.id} (#{i}/#{n})"
      i += 1

      s.source          = Document.find_or_create_with_content(decode(s[:source_code]))
      s.stdin           = Document.find_or_create_with_content(decode(s[:stdin]))
      s.stdout          = Document.find_or_create_with_content(decode(s[:stdout]))
      s.stderr          = Document.find_or_create_with_content(decode(s[:stderr]))
      s.expected_output = Document.find_or_create_with_content(decode(s[:expected_output]))
      s.compile_output  = Document.find_or_create_with_content(       s[:compile_output])
      s.message         = Document.find_or_create_with_content(       s[:message])

      s.save
    end

    remove_column :submissions, :source_code,     :text
    remove_column :submissions, :stdin,           :text
    remove_column :submissions, :stdout,          :text
    remove_column :submissions, :stderr,          :text
    remove_column :submissions, :expected_output, :text
    remove_column :submissions, :compile_output,  :text
    remove_column :submissions, :message,         :text
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
