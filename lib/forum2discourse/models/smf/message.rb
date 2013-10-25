require 'htmlentities'
class Forum2Discourse::Models::SMF::Message
  include DataMapper::Resource

  storage_names[:default] = "smf_messages"

  property :id,   Serial, field: 'ID_MSG'
  property :created_at, EpochTime, field: 'posterTime'
  property :topic_id, Integer, field: 'ID_TOPIC'
  #property :board_id, Integer, field: 'ID_BOARD'
  property :user_id, Integer, field: 'ID_MEMBER'
  property :body, Text, field: 'body'
  property :subject, Text, field: 'subject'

  belongs_to :topic, 'Forum2Discourse::Models::SMF::Topic'
  #belongs_to :board, 'Forum2Discourse::Models::SMF::Board'
  belongs_to :user, 'Forum2Discourse::Models::SMF::User'
  has n, :attachments, 'Forum2Discourse::Models::SMF::Attachment'

  def to_discourse
    return nil if topic==nil or topic.board==nil or topic.board.category==nil?
    duser = user.nil? ? Forum2Discourse::Models::Discourse::User.anonymous : user.to_discourse
    post = Forum2Discourse::Models::Discourse::Post.new(
      title: subject,
      category: topic.board.subject,
      user: duser,
      raw: HTMLEntities.new.decode(body).gsub("[code]","\n```cpp\n").gsub("[/code]","\n```\n").gsub("<br/>","\n").gsub("<br />","\n"),
      created_at: created_at
    )
    attachments.each do |attachment|
        if File.extname(attachment.filename).downcase == "jpg" || File.extname(attachment.filename).downcase == "gif" || File.extname(attachment.filename).downcase == "jpeg" || File.extname(attachment.filename).downcase == "png"
            raw = raw + "\n" + "<img src=\"" + attachment.url + "\"/>"
        else
            raw = raw + "\n" + "<a class=\"attachment\" href=\"" + attachment.url + "\">" + attachment.filename + "</a> (" + ("%0.2f" % attachment.size/1000) + ")"
        end
    end
    
    raw.gsub!("http://forum.openframeworks.cc/index.php/topic,([0-9]+)(.([0-9]+)?(.html)?(#msg[0-9]+)","http://forum.openframeworks.cc/t/l/\1")
    raw.gsub!("http://forum.openframeworks.cc/index.php?topic=([0-9]+)(.([0-9]+)?(.html)?(#msg[0-9]+)","http://forum.openframeworks.cc/t/l/\1")
    return post
  end
end
