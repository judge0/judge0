class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_archived, :source_file, :compile_cmd, :run_cmd
end
