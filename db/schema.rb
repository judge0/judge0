# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_28_155848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", id: :string, force: :cascade do |t|
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "compile_cmd"
    t.string "run_cmd"
    t.string "source_file"
    t.boolean "is_archived", default: false
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.text "source_code"
    t.integer "language_id"
    t.text "stdin"
    t.text "expected_output"
    t.text "stdout"
    t.integer "status_id"
    t.datetime "created_at"
    t.datetime "finished_at"
    t.decimal "time"
    t.integer "memory"
    t.text "stderr"
    t.string "token"
    t.integer "number_of_runs"
    t.decimal "cpu_time_limit"
    t.decimal "cpu_extra_time"
    t.decimal "wall_time_limit"
    t.integer "memory_limit"
    t.integer "stack_limit"
    t.integer "max_processes_and_or_threads"
    t.boolean "enable_per_process_and_thread_time_limit"
    t.boolean "enable_per_process_and_thread_memory_limit"
    t.integer "max_file_size"
    t.text "compile_output"
    t.integer "exit_code"
    t.integer "exit_signal"
    t.text "message"
    t.decimal "wall_time"
    t.string "compiler_options"
    t.string "command_line_arguments"
    t.boolean "redirect_stderr_to_stdout"
    t.string "callback_url"
    t.binary "additional_files"
    t.boolean "enable_network"
    t.datetime "started_at"
    t.datetime "queued_at"
    t.datetime "updated_at"
    t.string "queue_host"
    t.string "execution_host"
    t.index ["token"], name: "index_submissions_on_token"
  end

end
