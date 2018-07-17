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

ActiveRecord::Schema.define(version: 2018_05_13_093710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "digest", null: false
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

  create_table "submission_results", force: :cascade do |t|
    t.bigint "submission_id", null: false
    t.bigint "test_case_id", null: false
    t.bigint "stdout_id"
    t.bigint "stderr_id"
    t.bigint "compile_output_id"
    t.bigint "sandbox_message_id"
    t.bigint "internal_message_id"
    t.decimal "time"
    t.decimal "wall_time"
    t.integer "memory"
    t.integer "exit_code"
    t.integer "exit_signal"
    t.integer "status_id"
    t.integer "index"
    t.datetime "created_at"
    t.datetime "finished_at"
    t.index ["compile_output_id"], name: "index_submission_results_on_compile_output_id"
    t.index ["internal_message_id"], name: "index_submission_results_on_internal_message_id"
    t.index ["sandbox_message_id"], name: "index_submission_results_on_sandbox_message_id"
    t.index ["stderr_id"], name: "index_submission_results_on_stderr_id"
    t.index ["stdout_id"], name: "index_submission_results_on_stdout_id"
    t.index ["submission_id", "test_case_id"], name: "index_submission_results_on_submission_id_and_test_case_id"
    t.index ["submission_id"], name: "index_submission_results_on_submission_id"
    t.index ["test_case_id"], name: "index_submission_results_on_test_case_id"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "language_id"
    t.integer "status_id"
    t.datetime "created_at"
    t.datetime "finished_at"
    t.string "uuid"
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
    t.bigint "source_id"
    t.bigint "test_suite_id"
    t.bigint "compile_output_id"
    t.bigint "internal_message_id"
    t.index ["compile_output_id"], name: "index_submissions_on_compile_output_id"
    t.index ["internal_message_id"], name: "index_submissions_on_internal_message_id"
    t.index ["source_id"], name: "index_submissions_on_source_id"
    t.index ["test_suite_id"], name: "index_submissions_on_test_suite_id"
    t.index ["uuid"], name: "index_submissions_on_uuid", unique: true
  end

  create_table "test_cases", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "input_id"
    t.bigint "output_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["input_id"], name: "index_test_cases_on_input_id"
    t.index ["output_id"], name: "index_test_cases_on_output_id"
    t.index ["uuid"], name: "index_test_cases_on_uuid", unique: true
  end

  create_table "test_suites", force: :cascade do |t|
    t.string "uuid", null: false
    t.text "test_case_ids", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_case_ids"], name: "index_test_suites_on_test_case_ids", unique: true
    t.index ["uuid"], name: "index_test_suites_on_uuid", unique: true
  end

end
