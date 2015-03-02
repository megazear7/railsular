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

ActiveRecord::Schema.define(version: 20150302144711) do

  create_table "assigned_geo_attrs", force: :cascade do |t|
    t.string   "value"
    t.string   "name"
    t.integer  "assigned_geometry_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "assigned_geo_attrs", ["assigned_geometry_id"], name: "index_assigned_geo_attrs_on_assigned_geometry_id"

  create_table "assigned_geometries", force: :cascade do |t|
    t.integer  "simulation_id"
    t.integer  "geometry_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "assigned_geometries", ["geometry_id"], name: "index_assigned_geometries_on_geometry_id"
  add_index "assigned_geometries", ["simulation_id"], name: "index_assigned_geometries_on_simulation_id"

  create_table "geometries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "geometries", ["project_id"], name: "index_geometries_on_project_id"

  create_table "geometry_attrs", force: :cascade do |t|
    t.string   "value"
    t.string   "name"
    t.integer  "geometry_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "geometry_attrs", ["geometry_id"], name: "index_geometry_attrs_on_geometry_id"

  create_table "jobs", force: :cascade do |t|
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

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "simulation_attrs", force: :cascade do |t|
    t.string   "value"
    t.string   "name"
    t.integer  "simulation_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "simulation_attrs", ["simulation_id"], name: "index_simulation_attrs_on_simulation_id"

  create_table "simulations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "simulations", ["project_id"], name: "index_simulations_on_project_id"

end
