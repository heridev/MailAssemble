Email Assemble
==============================

Email Assemble is the 100% open source Single Page Application autoresponder application built in Rails 4.2 and Angular 1.4.

Setup
=====

```
$ git clone git@github.com:heridev/MailAssemble.git
$ cd MailAssemble
$ bundle install
$ rake db:create
$ rake db:migrate
export DB_ADAPTER=postgress
export MANDRILL_API_KEY=HatU5GxeJFPo7zseDNozqr
export MANDRILL_USERNAME=youremailgoeshere@email.com
export USER_DELAYEDJOB=httpuserhere
export PASSWORD_DELAYEDJOB=mypass
$ rake jobs:work
$ rails server
```

Live Demo
=========
http://emailassemble.herokuapp.com


Sorting: Postgress and mysql support
====================================

As you know there are a lot of tutorials about how to implement the sorting options in different frameworks, jquery, or plain javascript, but most of the tutorials includes for the backend code some lines as follow:

```
Specification.all.each do |spec|
  if position = params[:specifications].index(spec.id.to_s)
    spec.update_attribute(:position, position + 1) unless spec.position == position + 1
  end
end
```

Which is not performant enough of course, in order to tackle that performance problem when updating elements after sorting them I have added two special sql queries that either work for postgress and mysql and you can select which one you want to use using an environment variable, by default if you don't provide any value will make use of postgress query:

```
export DB_ADAPTER=mysql
# or
export DB_ADAPTER=postgress
```

Emails
========

For sending emails for the time being is using Mandrill so you need to generate your own credentials and export them before to run rails server
```
export MANDRILL_API_KEY=HatU5GxeJFPo7zseDNozqr
export MANDRILL_USERNAME=youremailgoeshere@email.com
```

MANDRILL
=========
You must create a template within the mandrill templates section called "follow_ups":
![Mandrill template](https://www.evernote.com/shard/s250/sh/e18dcab5-a7ed-4178-a21f-95c54fef6907/9f1cd8559b5c00c4/res/5b4f3375-8b6e-4695-bbd9-3612527889eb/skitch.png)

The content for that template is pretty simple:
```
*|CONTENT|*
```

DELAYED JOBS
=============

It is using Delayed job as a primary background worker, because in case you want to deploy the autoresponder into heroku you do not need to install any other piece of software and also you can run delayed jobs in heroku for free.

In order to run delayed jobs in development mode, you have to run the jobs work command in console after exporting the USER_DELAYEDJOB and PASSWORD_DELAYEDJOB variables:
```
export USER_DELAYEDJOB=httpuserhere
export PASSWORD_DELAYEDJOB=mypass
rake jobs:work
```

As the autoresponder is using delayed jobs web gem you can manage the jobs visiting the route /delayed_secret_job which is defined in the config/routes.rb in case you want to customize the url.

Placeholder follow ups variables
================================
In case you want to include the name or email in your follow ups you can do it using the placeholders for instance:
Hello {{name}}
Your email is {{email}}

Available variables at this time:
- name
- email


Scheduled follow ups
=====================

In order to send scheduled follow ups you can make use of:
```
bundle exec rake autoresponder:send_scheduled_follow_ups
```

So, for example you can create a cron job and invoke it each 10 minutes, if you're using heroku you can use scheduler

NOTE: in case that you want to make sure that every follow up is sent correctly you can run this command each 30 minutes as well:
```
bundle exec rake autoresponder:send_oldest_follow_ups
```

TODO LIST
==========

- Support different email service provider for instance: MailGun, Sailthru, ZendGrid, etc.
- Enable by configuration background worker implementations(rescue, sidekiq, etc) not only delayed jobs.

