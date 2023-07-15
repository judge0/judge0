class ChangeDecimalPrecision < ActiveRecord::Migration[5.0]
    def change
      change_column :submissions, :time, :decimal, precision: 10, scale: 5
      change_column :submissions, :cpu_time_limit, :decimal, precision: 10, scale: 5
      change_column :submissions, :cpu_extra_time, :decimal, precision: 10, scale: 5
      change_column :submissions, :wall_time_limit, :decimal, precision: 10, scale: 5
      change_column :submissions, :wall_time, :decimal, precision: 10, scale: 5
    end
  end
