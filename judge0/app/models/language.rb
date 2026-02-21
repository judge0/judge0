# == Schema Information
#
# Table name: languages
#
#  id          :integer          not null, primary key
#  name        :string
#  compile_cmd :string
#  run_cmd     :string
#  source_file :string
#  is_archived :boolean          default(FALSE)
#

class Language < ApplicationRecord
  validates :name, presence: true
  validates :source_file, :run_cmd, presence: true, unless: -> { is_project }
  default_scope { where(is_archived: false).order(name: :asc) }

  def is_project
    name == "Multi-file program"
  end
end
