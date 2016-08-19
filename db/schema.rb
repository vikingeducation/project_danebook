# Schema

ActiveRecord::Schema.define(version: 20_160_818_232_230) do
  create_table 'comments', force: :cascade do |t|
    t.string   'body'
    t.integer  'user_id'
    t.integer  'commentable_id'
    t.string   'commentable_type'
    t.datetime 'created_at',       null: false
    t.datetime 'updated_at',       null: false
  end

  add_index 'comments',
            %w(commentable_type commentable_id),
            name: 'index_comments_on_commentable_type_and_commentable_id'
  add_index 'comments', ['user_id'], name: 'index_comments_on_user_id'

  create_table 'friendings', force: :cascade do |t|
    t.integer  'friend_id'
    t.integer  'friender_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'friendings', %w(friend_id friender_id),
            name: 'index_friendings_on_friend_id_and_friender_id',
            unique: true

  create_table 'likes', force: :cascade do |t|
    t.integer  'likeable_id'
    t.string   'likeable_type'
    t.integer  'user_id'
    t.datetime 'created_at',    null: false
    t.datetime 'updated_at',    null: false
  end

  add_index 'likes', %w(likeable_type likeable_id),
            name: 'index_likes_on_likeable_type_and_likeable_id'
  add_index 'likes', %w(user_id likeable_id likeable_type),
            name: 'index_likes_on_user_id_and_likeable_id_and_likeable_type',
            unique: true

  create_table 'photos', force: :cascade do |t|
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.integer  'user_id'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
  end

  create_table 'posts', force: :cascade do |t|
    t.text     'body'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'profiles', force: :cascade do |t|
    t.string   'first_name'
    t.string   'last_name'
    t.datetime 'birthday'
    t.string   'about'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer  'picture_id'
    t.integer  'cover_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email'
    t.string   'password_digest'
    t.string   'auth_token'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
  end

  add_index 'users', ['auth_token'],
            name: 'index_users_on_auth_token',
            unique: true
  add_index 'users', ['email'], name: 'index_users_on_email', unique: true
end
