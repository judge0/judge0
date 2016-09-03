# == Schema Information
#
# Table name: languages
#
#  id          :integer          not null, primary key
#  name        :string
#  compile_cmd :string
#  run_cmd     :string
#

class Language < ApplicationRecord
  validates :name, presence: true
end
