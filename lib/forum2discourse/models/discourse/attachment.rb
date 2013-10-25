class Forum2Discourse::Models::SMF::Attachment
  include DataMapper::Resource

  storage_names[:default] = "smf_attachments"

  property :id,   Serial, field: 'ID_ATTACH'
  property :id_user,   Serial, field: 'ID_MEMBER'
  property :filename, Text, field: 'filename'
  property :size, Integer, field: 'size'
  property :width, Integer, field: 'width'
  property :height, Integer, field: 'height'
  
  belongs_to :message, 'Forum2Discourse::Models::SMF::Message'  
  belongs_to :user, 'Forum2Discourse::Models::SMF::User'  

  def to_discourse
    duser = user.nil? ? Forum2Discourse::Models::Discourse::User.anonymous : user.to_discourse
    Forum2Discourse::Models::Discourse::Upload.new(
      original_filename: filename,
      filesize: size,
      width: width,
      height: height
      created_at: message.created_at
      updated_at: message.created_at
      url: "/smf_attachments/" + id + "/" + filename
    )
  end
end
