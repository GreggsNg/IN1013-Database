-- 1. Insert into events table the information ‘Fluffy’, ‘2020-10-15’, ‘vet’, ‘antibiotics’.

INSERT INTO petEvent (petname, eventdate, eventtype, remark)
VALUES ('Fluffy', '2020-10-15', 'vet', 'antibiotics');

-- 2. Insert into events table the information ‘Hammy’, ‘2020-10-15’, ‘vet’, ‘antibiotics’.
-- First, insert Hammy into the petPet table if it does not exist.
INSERT INTO petPet (petname, owner, species, gender, birth)
VALUES ('Hammy', 'Diane', 'M', 'Male', '2010-10-30');

-- Now, insert the event for Hammy.
INSERT INTO petEvent (petname, eventdate, eventtype, remark)
VALUES ('Hammy', '2020-10-15', 'vet', 'antibiotics');

-- 3. It appeared that Fluffy had 5 kittens 2 of which are male.

INSERT INTO petEvent (petname, eventdate, eventtype, remark)
VALUES ('Fluffy', CURRENT_DATE, 'birth', 'Fluffy had 5 kittens, 2 male');

-- 4. On “1997-08-03” it was Claws who broke the rib.
INSERT INTO petEvent (petname, eventdate, eventtype, remark)
VALUES ('Claws', '1997-08-03', 'injury', 'broke the rib');

-- 5. Puffball died on ‘2020-09-01’.
UPDATE petPet
SET death = '2020-09-01'
WHERE petname = 'Puffball';

-- 6. Harold asked me to remove his dog from my database due to GDPR.
DELETE FROM petEvent
WHERE petname IN (SELECT petname FROM petPet WHERE owner = 'Harold');

DELETE FROM petPet
WHERE owner = 'Harold';
