# == Schema Information
#
# Table name: documents
#
#  digest     :string           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_documents_on_digest  (digest) UNIQUE
#

class Document < ApplicationRecord
  self.primary_key = "digest"

  LOCAL_STORAGE_PATH = Rails.root.to_s + "/data/documents/"

  validates :digest, presence: true
  validates :digest, uniqueness: true

  after_validation  :restore_data
  after_create :save_to_storage

  attr :content

  def self.find_or_create_with_content(content)
    return nil unless content

    document = Document.new(content: content)
    if document.save
      return document
    end

    Document.find(document.digest)
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

  private

  def restore_data
    DocumentService.save(self) if !self.errors.empty? && self.new_record?
  end

  def save_to_storage
    DocumentService.save(self)
  end
end
