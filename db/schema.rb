# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150326132933) do

  create_table "apps", force: true do |t|
    t.string   "name"
    t.string   "app_hex_code"
    t.boolean  "test"
    t.string   "app_bin"
    t.string   "batch_queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assigned_geo_attrs", force: true do |t|
    t.string   "value"
    t.integer  "assigned_geometry_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "attribute_descriptor_id"
  end

  add_index "assigned_geo_attrs", ["assigned_geometry_id"], name: "index_assigned_geo_attrs_on_assigned_geometry_id"

  create_table "assigned_geometries", force: true do |t|
    t.integer  "simulation_id"
    t.integer  "geometry_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "assigned_geometries", ["geometry_id"], name: "index_assigned_geometries_on_geometry_id"
  add_index "assigned_geometries", ["simulation_id"], name: "index_assigned_geometries_on_simulation_id"

  create_table "attribute_descriptor_values", force: true do |t|
    t.integer  "attribute_descriptor_id"
    t.string   "value"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "attribute_descriptor_values", ["attribute_descriptor_id"], name: "index_attribute_descriptor_values_on_attribute_descriptor_id"

  create_table "attribute_descriptors", force: true do |t|
    t.integer  "geometry_type_id"
    t.string   "attr_type"
    t.string   "display"
    t.string   "validation"
    t.string   "usage"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
  end

  add_index "attribute_descriptors", ["geometry_type_id"], name: "index_attribute_descriptors_on_geometry_type_id"

  create_table "geometries", force: true do |t|
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "geo_file_name"
    t.string   "geo_content_type"
    t.integer  "geo_file_size"
    t.datetime "geo_updated_at"
    t.boolean  "final"
    t.integer  "geometry_type_id"
  end

  add_index "geometries", ["project_id"], name: "index_geometries_on_project_id"

  create_table "geometry_attrs", force: true do |t|
    t.string   "value"
    t.integer  "geometry_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "attribute_descriptor_id"
  end

  add_index "geometry_attrs", ["geometry_id"], name: "index_geometry_attrs_on_geometry_id"

  create_table "geometry_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_descriptors", force: true do |t|
    t.string   "job_type"
    t.integer  "script_number"
    t.string   "test_compute_resources"
    t.string   "prod_compute_resources"
    t.string   "test_walltime"
    t.string   "prod_walltime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "setup_method"
  end

  create_table "jobs", force: true do |t|
    t.string   "status"
    t.string   "pbsid"
    t.string   "job_path"
    t.string   "script_name"
    t.integer  "simulation_id"
    t.integer  "geometry_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "jobs", ["geometry_id"], name: "index_jobs_on_geometry_id"
  add_index "jobs", ["simulation_id"], name: "index_jobs_on_simulation_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "results", force: true do |t|
    t.boolean  "generic",     default: false
    t.string   "x_var"
    t.string   "y_var"
    t.string   "result_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results_simulations", force: true do |t|
    t.integer "result_id"
    t.integer "simulation_id"
  end

  create_table "simulation_attrs", force: true do |t|
    t.string   "value"
    t.integer  "simulation_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "attribute_descriptor_id"
  end

  add_index "simulation_attrs", ["simulation_id"], name: "index_simulation_attrs_on_simulation_id"

  create_table "simulations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "final"
  end

  add_index "simulations", ["project_id"], name: "index_simulations_on_project_id"

end
