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

  private

  def restore_data
    DocumentService.save(self) if !self.errors.empty? && self.new_record?
  end

  def save_to_storage
    DocumentService.save(self)
  end
end
