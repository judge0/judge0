# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  uuid       :string           not null
#  digest     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_documents_on_digest  (digest) UNIQUE
#  index_documents_on_uuid    (uuid) UNIQUE
#

class Document < ApplicationRecord
  LOCAL_STORAGE = Rails.root.to_s + "/data/documents/"

  validates :digest, uniqueness: true

  after_validation  :restore_data

  before_create :generate_uuid
  
  after_create :save_to_storage

  attr :content
  attr_reader :file_path

  def readonly?
    new_record? ? false : true
  end

  def content
    @content ||= DocumentService.read(self)
  end

  def content=(content)
    @content = content
    self.digest = Digest::SHA512.hexdigest(@content)
    @file_path = LOCAL_STORAGE + digest
  end

  def file_path
    return nil unless digest
    @file_path ||= LOCAL_STORAGE + digest
  end

  private

  def restore_data
    DocumentService.save(self) if !self.errors.empty? && self.new_record?
  end

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists?(uuid: uuid)
  end

  def save_to_storage
    DocumentService.save(self)
  end
end
