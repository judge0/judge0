module DocumentService
  @@aws_client ||= Aws::S3::Client.new
  @@aws_bucket ||= ENV.fetch("AWS_BUCKET")
  @@aws_available = -> {
    begin
      @@aws_client.head_bucket({
        bucket: @@aws_bucket
      })
      true
    rescue
      false
    end
  }.call

  def self.aws_available?
    @@aws_available
  end

  def self.save(document)
    return unless document.try(:content)
    local_save(document) unless aws_save(document)
  end

  def self.local_save(document)
    return unless document.try(:content)
    return if     exists_locally?(document)

    File.open(document.file_path, "w") do |f|
      begin
        f.flock(File::LOCK_EX)
        f.write(document.content)
      ensure
        f.flock(File::LOCK_UN)
      end
    end
  end

  def self.aws_save(document)
    return false unless aws_available?
    return false unless document.try(:content)
    return true  if     exists_on_aws?(document)
    @@aws_client.put_object(
      bucket: @@aws_bucket,
      key: document.digest,
      body: document.content,
      content_type: "text/plain"
    )
    return true
  rescue
    return false
  end


  def self.exists?(document)
    exists_on_aws?(document) || exists_locally?(document)
  end

  def self.exists_locally?(document)
    File.exist?(document.file_path)
  end

  def self.exists_on_aws?(document)
    return false unless aws_available?
    return false unless document.try(:digest)
    @@aws_client.head_object({
        bucket: @@aws_bucket,
        key: document.digest
    })
    return true
  rescue
    return false
  end

  def self.read(document)
    read_locally(document) || read_from_aws(document)
  end

  def self.read_locally(document)
    File.read(document.file_path)
  rescue
    nil
  end

  def self.read_from_aws(document)
    return nil unless aws_available?
    @@aws_client.get_object(
      bucket: @@aws_bucket,
      key: document.digest,
      response_target: document.file_path 
    )
    read_locally(document)
  rescue
    nil
  end
end