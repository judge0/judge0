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
  validates :name, :run_cmd, :source_file, presence: true
  default_scope { where(is_archived: false).order(name: :asc) }
end
