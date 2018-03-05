module DocumentService
  @@aws_client = Aws::S3::Client.new
  @@aws_bucket = ENV.fetch("AWS_BUCKET")
  
  def self.save(document)
    return unless document.content
    local_save(document) unless aws_save(document)
  end

  def self.local_save(document)
    return unless document.content
    return if exists_locally?(document)

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
    return false unless document.content
    return true if exists_on_aws?(document)
    @@aws_client.put_object(
      key: document.digest,
      body: document.content,
      bucket: @@aws_bucket,
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
    @@aws_client.get_object(
        key: document.digest,
        bucket: @@aws_bucket,
        range: "bytes=0-0"
    )
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
    @@aws_client.get_object(
      key: document.digest,
      bucket: @@aws_bucket,
      response_target: document.file_path 
    )
    read_locally(document)
  rescue
    nil
  end
end