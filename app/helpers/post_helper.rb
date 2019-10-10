module PostHelper

    def post_excerpt(post)
        sanitize(truncate(post.body, length: 50)) if post && post.body.present?
    end

end
