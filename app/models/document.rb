# == Schema Information
#
# Table name: documents
#
#  id         :bigint(8)        not null, primary key
#  digest     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_documents_on_digest  (digest) UNIQUE
#

class Document < ApplicationRecord
  LOCAL_STORAGE_PATH = "#{Rails.root}/data/documents"

  validates :digest, presence:   true
  validates :digest, uniqueness: true

  after_validation -> { DocumentService.save(self) }
  after_create     -> { DocumentService.save(self) }

  attr_accessor :content

  def self.find_or_create_with_content(content)
    return nil unless content
    new_document = Document.new(content: content)
    Document.transaction do
      old_document = Document.find_by(digest: new_document.digest)
      return old_document if old_document
      new_document.save(validate: false)
    end
    return new_document
  end

  def content
    @content ||= DocumentService.read(self)
  end

  def content=(content)
    @content = content
    self.digest = content ? Digest::SHA512.hexdigest(@content) : nil
  end

  def file_path
    digest ? "#{LOCAL_STORAGE_PATH}/#{digest}" : nil
  end

  def readonly?
    !new_record?
  end
end
