Given the PCI compliance issues in this code,
I've created a "ENC_KEY" environment variable that is generated via openssl.  This
key is stored separately from the code base to maintain compliance.  I've created a
new payment_details table to store the encrypted version of the credit card number,
the expiration, payer's full name, zip code, and last 4 of the credit card.  You cannot
store the CVV per PCI Compliance so that has been removed.

I've removed credit_card_number, cvv, and expiry from the Users table.  There was a
consideration to iterate that data, encrypt the current credit cards, and create the
associated payment_details, but information is missing.  In the current iteration,
we do not store the credit card holder's name, zip, or any other information. I decided
to avoid this iteration for the sake of brevity and addressing the task.

Orders now have an associated join table for order_payment_details.  This links orders with payment_details.  It allows users to split order costs across multiple payment methods.

Order#order_items should either be a JSON type or as a Separate table.  In the long run, depending on the amount of orders one expects over the coming months, to use a separate table for the order line items.  This is taking into consideration for tracking individual items per order and potential metrics for that in the future.

I created MessageChannels to hold all individual messages.  The channel uses an enum to
determine the type of communication going through it: general, product orders, and website support.  I've
also added a channel_for_id field that will hold a related id to the specific type.  It is not necessarily
the rails way of doing a polymorphic association, but it avoids all of the pitfalls with performance as the
table grows. When a user initiates a message then I check to see if there is a uuid that has been passed
in. If the uuid is passed in, and exists, then we return its associated messages.  Otherwise, we generate a new
Message channel and associate the incoming message to that channel.

