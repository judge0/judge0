# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
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

  after_create -> { DocumentService.save(self) }

  attr :content

  def self.find_or_create_with_content(content)
    return nil unless content

    document = Document.new(content: content)
    return document if document.save

    Document.find_by(digest: document.digest)
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
    new_record? ? false : true
  end
end
