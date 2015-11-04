class FollowUpMessageMailer < MandrillMailer::TemplateMailer
  default from: 'heriberto.perez@magmalabs.io'

  def send_email(follow_up, subscriber)
    recipients = [
      {
        name: subscriber.name,
        email: subscriber.email
      }
    ]

    mandrill_mail(
      template: 'follow_ups',
      subject: replace_placeholder_values(follow_up.title, subscriber),
      to: recipients,
      vars: {
        'CONTENT' => replace_placeholder_values(follow_up.content, subscriber),
      },
      important: true,
      inline_css: true,
     )
  end

  def replace_placeholder_values(content, subscriber)
    template = Liquid::Template.parse(content)
    hash_values = find_placeholder_subscriber(subscriber)
    template.render(hash_values)
  end

  def find_placeholder_subscriber(subscriber)
    @placeholder_values ||= {
      'name' => subscriber.name,
      'email' => subscriber.email
    }
  end
end
