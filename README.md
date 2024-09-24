# README

This is the take home project for the interview process at Rugiet.

## Setup

1. Clone the repository
2. Run `bundle install`
3. Run `rails db:migrate`
4. Run `rails db:seed`
5. Run `rails s`
6. Open your browser and navigate to `http://localhost:3000`

## The Application

The application is a small extract of our main application. It's a part of the messaging system between users and doctors.
Users with active orders leverage the chat system to ask their doctor questions, ask for changes, and to perform refills.

Whilst this application is not representative of our main application, performing the requested task will expose you to the
same kinds of challenges you'll face in the real application.

## The Task

Our users sometimes need to contact our customer care team. Add a customer care user that can chat with our users and
the doctor about a given order.
The customer care user should be able to see all messages in the system, but doctors can't see messages
between the user and the customer care user and users can't see messages between the doctor and the customer care user.
Also write a test plan for our QA tester to be put in the PR.

## Tips

Treat this task as if you were working a real ticket on our team. Think about how the code currently works and how you
would feel maintaining it and what you add to it 6 months from now.
