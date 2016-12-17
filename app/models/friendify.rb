class Friendify
  class << self
    include ActionView::Helpers::UrlHelper

    def friendship(user, friend)

      if user.id == friend.id

        [
          :danger,
          [
            "You can't friend yourself!",
            "Lonely Bastard..."
          ]
        ]

      elsif friends?(user, friend)

        [
          :danger,
          ["You're Already Friends!"]
        ]

      elsif accepting_request?(user, friend)

        accept_request(user, friend)

      else

        send_request(user, friend)

      end
    end

    def clear_friendship(user, friend)
      FriendsUser.
        where(user_id: user.id, friend_id: friend.id).
        or(
          FriendsUser.
            where(user_id: friend.id, friend_id: user.id)
          ).
        destroy_all

      FriendRequest.
        where(user_id: user.id, request_id: friend.id).
        or(FriendRequest.
            where(user_id: friend.id, request_id: user.id)
          ).
        destroy_all
    end

    private

      def accept_request(user, friend)

        clear_friendship(user, friend)

        set_friends(user, friend)

        [
          :success,
          ["Friend Request Accepted!"]
        ]

      end


      def send_request(user, friend)

        request = FriendRequest.new(user_id: friend.id, request_id: user.id)

        if request.save

          messages =  [
                        "#{user.profile.first_name} #{user.profile.last_name} would like to be your friend.
                        #{link_to "Accept", Rails.application.routes.url_helpers.user_friends_path(user), method: :post, class: "btn btn-default pull-right friend"}
                        #{link_to "Reject", Rails.application.routes.url_helpers.user_friends_path(user), method: :delete, class: "btn btn-default pull-right unfriend"}"
                      ]
          Notice.create(user: friend, title: "New Friend Request", messages: messages )

          [
            :success,
            ["Friend Request Sent!"]
          ]

        else

          [
            :danger,
            ["Friend Request Already Sent. Stop buggin them!"]
          ]

        end
      end

      def accepting_request?(user, friend)
        friend.requested_friends.include?(user)
      end

      def friends?(user, friend)
        user.friends.include?(friend)
      end


      def set_friends(user, friend)

        user.friends << friend

        friend.friends << user

        friend.notices.each do |notice|
          notice.destroy if notice.messages.any?{|msg| msg =~ /#{user.profile.first_name} #{user.profile.last_name} would like to be your friend./}
        end
        user.notices.each do |notice|
          notice.destroy if notice.messages.any?{|msg| msg =~ /#{friend.profile.first_name} #{friend.profile.last_name} would like to be your friend./}
        end


        messages =  [
                      "You have a new friendship with #{friend.profile.first_name} #{friend.profile.last_name}.",
                      "#{link_to "Click Here to view their profile", Rails.application.routes.url_helpers.user_path(friend)}"
                    ]
        Notice.create(user: user, title: "Friend request Accepted", messages: messages )

        messages =  [
                      "You have a new friendship with #{user.profile.first_name} #{user.profile.last_name}.",
                      "#{link_to "Click Here to view their profile", Rails.application.routes.url_helpers.user_path(user)}"
                    ]
        Notice.create(user: friend, title: "Friend request Accepted", messages: messages )

      end
  end
end
