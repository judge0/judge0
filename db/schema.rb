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

ActiveRecord::Schema.define(version: 20180312213402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", primary_key: "digest", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["digest"], name: "index_documents_on_digest", unique: true
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "compile_cmd"
    t.string "run_cmd"
    t.string "source_file"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "language_id"
    t.integer "status_id"
    t.datetime "created_at"
    t.datetime "finished_at"
    t.decimal "time"
    t.integer "memory"
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
    t.integer "exit_code"
    t.integer "exit_signal"
    t.decimal "wall_time"
    t.string "source_digest"
    t.string "stdin_digest"
    t.string "stdout_digest"
    t.string "stderr_digest"
    t.string "expected_output_digest"
    t.string "compile_output_digest"
    t.string "message_digest"
    t.index ["token"], name: "index_submissions_on_token"
  end

end
