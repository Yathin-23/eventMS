-- Create Venues table
CREATE TABLE Venues (
    VenueID VARCHAR(10) PRIMARY KEY,
    VenueName VARCHAR(100) NOT NULL,
    Location VARCHAR(150),
    Capacity INT
);

-- Create Events table
CREATE TABLE Events (
    EventID VARCHAR(10) PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    VenueID VARCHAR(10),
    Description TEXT,
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID)
);

-- Create Attendees table
CREATE TABLE Attendees (
    AttendeeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

-- Create Registrations table
CREATE TABLE Registrations (
    RegistrationID VARCHAR(10) PRIMARY KEY,
    EventID VARCHAR(10),
    AttendeeID VARCHAR(10),
    RegistrationDate DATE NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Create Organizers table
CREATE TABLE Organizers (
    OrganizerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150)
);


CREATE TABLE EventOrganizers (
    EventID VARCHAR(10),
    OrganizerID VARCHAR(10),
    PRIMARY KEY (EventID, OrganizerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);


CREATE TABLE Speakers (
    SpeakerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT,
    ContactInfo VARCHAR(150)
);


CREATE TABLE EventSpeakers (
    EventID VARCHAR(10),
    SpeakerID VARCHAR(10),
    Role VARCHAR(50), -- e.g., 'Chief Guest', 'Keynote Speaker'
    PRIMARY KEY (EventID, SpeakerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID)
);
-- Sponsors table
CREATE TABLE Sponsors (
    SponsorID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    Contribution DECIMAL(10,2) CHECK (Contribution >= 0)
);

-- Junction table for many-to-many
CREATE TABLE EventSponsors (
    EventID VARCHAR(10),
    SponsorID VARCHAR(10),
    PRIMARY KEY (EventID, SponsorID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
    FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID) ON DELETE CASCADE
);

-- Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10) PRIMARY KEY,
    EventID VARCHAR(10),
    Type VARCHAR(50),  -- e.g., VIP, Regular, Student
    Price DECIMAL(8,2) CHECK (Price >= 0),
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE
);

CREATE TABLE Performers (
    PerformerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),     -- Rock, EDM, Classical, Pop
    ContactInfo VARCHAR(150)
);

-- Junction (many-to-many) since one performer can do many events
CREATE TABLE EventPerformers (
    EventID VARCHAR(10),
    PerformerID VARCHAR(10),
    Role VARCHAR(50),  -- Headliner, Opening Act, Guest, etc.
    PRIMARY KEY (EventID, PerformerID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE,
    FOREIGN KEY (PerformerID) REFERENCES Performers(PerformerID) ON DELETE CASCADE
);

INSERT INTO Venues (VenueID, VenueName, Location, Capacity) VALUES
('V01', 'Valhalla palace', '123 Main St, Wakanda', 500),
('V02', 'Conference Center', '456 Elm St, Sokovia', 300),
('V03', 'Baxter Building', '789 Park Ave, Latveria', 1000);


INSERT INTO Events (EventID, EventName, EventDate, VenueID, Description) VALUES
('E01', 'Tech Conference 2025', '2025-10-15', 'V02', 'Conference on Future Foundation'),
('E02', 'Music Festival', '2025-10-20', 'V03', 'Outdoor music festival featuring various artists.'),
('E03', 'Art Expo', '2025-10-05', 'V01', 'Exhibition of modern art and sculptures.');


INSERT INTO Attendees (AttendeeID, Name, Email, Phone) VALUES
('A01', 'Maria Hill', 'Maria@mail.com', '555-1234'),
('A02', 'Nick Fury', 'Nick@mail.com', '555-5678'),
('A03', 'Carol Danvers', 'carol@mail.com', '555-8765');


INSERT INTO Registrations (RegistrationID, EventID, AttendeeID, RegistrationDate) VALUES
('R01', 'E01', 'A01', '2025-10-01'),
('R02', 'E01', 'A02', '2025-10-02'),
('R03', 'E02', 'A03', '2025-10-15');


INSERT INTO Organizers (OrganizerID, Name, ContactInfo) VALUES
('O01', 'EventCo', 'contact@eventco.com'),
('O02', 'MusicMasters', 'info@musicmasters.com');


INSERT INTO EventOrganizers (EventID, OrganizerID) VALUES
('E01', 'O01'),
('E02', 'O02'),
('E03', 'O01');


INSERT INTO Speakers (SpeakerID, Name, Bio, ContactInfo) VALUES
('S01', 'Dr. Reed Richards', 'Expert in AI and Machine Learning.', 'reed@mail.com'),
('S02', 'Ms. Kamala Khan', 'Renowned musician and composer.', 'kate@mail.com'),
('S03', 'Mr. Wilson Fisk', 'Expert in art collection.','Fisk@mail.com');


INSERT INTO EventSpeakers (EventID, SpeakerID, Role) VALUES
('E01', 'S01', 'Keynote Speaker'),
('E02', 'S02', 'Chief Guest');

INSERT INTO Sponsors (SponsorID, Name, ContactInfo, Contribution) VALUES
('SP01', 'Stark Industries', 'tony@stark.com', 1000000.00),
('SP02', 'Oscorp', 'norman@oscorp.com', 500000.00),
('SP03', 'Daily Bugle', 'jjj@bugle.com', 250000.00);

INSERT INTO EventSponsors (EventID, SponsorID) VALUES
('E01', 'SP01'), 
('E02', 'SP02'), 
('E02', 'SP03'); 

INSERT INTO Tickets (TicketID, EventID, Type, Price) VALUES
('T01', 'E01', 'VVIP', 4999.99),
('T02', 'E01', 'Regular', 1999.99),
('T03', 'E02', 'VIP', 2999.99),
('T04', 'E02', 'Student', 999.99),
('T05', 'E03', 'Regular', 1500.00);

-- Performers
INSERT INTO Performers (PerformerID, Name, Genre, ContactInfo) VALUES
('P01', 'Michael Jackson', 'Pop', 'jackson@mail.com'),
('P02', 'Imagine Dragons', 'Rock', 'dragons@mail.com'),
('P03', 'A. R. Rahman', 'Classical Fusion', 'arrahman@mail.com'),
('P04', 'Anirudh', 'Rock', 'ani@mail.com');

-- Event Performers (who’s playing where)
INSERT INTO EventPerformers (EventID, PerformerID, Role) VALUES
('E02', 'P01', 'Headliner'),
('E02', 'P02', 'Guest DJ'),
('E03', 'P03', 'Special Performance'),
('E02', 'P04', 'Opening Act');


-- 1. List all events with their venues
SELECT e.EventName, v.VenueName, v.Location
FROM Events e
JOIN Venues v ON e.VenueID = v.VenueID;

-- 2. Show all tickets available for 'Music Festival'
SELECT t.Type, t.Price
FROM Tickets t
JOIN Events e ON t.EventID = e.EventID
WHERE e.EventName = 'Music Festival';

-- 3. Find all attendees registered for 'Tech Conference 2025'
SELECT a.Name, a.Email
FROM Attendees a
JOIN Registrations r ON a.AttendeeID = r.AttendeeID
JOIN Events e ON r.EventID = e.EventID
WHERE e.EventName = 'Tech Conference 2025';
-- 4. List sponsors and their contributions for each event
SELECT e.EventName, s.Name AS SponsorName, s.Contribution
FROM EventSponsors es
JOIN Events e ON es.EventID = e.EventID
JOIN Sponsors s ON es.SponsorID = s.SponsorID;

-- 5. Find the total sponsorship amount per event
SELECT e.EventName, SUM(s.Contribution) AS TotalSponsorship
FROM EventSponsors es
JOIN Events e ON es.EventID = e.EventID
JOIN Sponsors s ON es.SponsorID = s.SponsorID
GROUP BY e.EventName;
-- 6. List speakers for each event with their role
SELECT e.EventName, sp.Name AS Speaker, es.Role
FROM EventSpeakers es
JOIN Events e ON es.EventID = e.EventID
JOIN Speakers sp ON es.SpeakerID = sp.SpeakerID;

-- 7. Show all events organized by 'EventCo'
SELECT e.EventName, e.EventDate
FROM EventOrganizers eo
JOIN Events e ON eo.EventID = e.EventID
JOIN Organizers o ON eo.OrganizerID = o.OrganizerID
WHERE o.Name = 'EventCo';
-- 8. Count number of attendees registered per event
SELECT e.EventName, COUNT(r.AttendeeID) AS TotalAttendees
FROM Events e
LEFT JOIN Registrations r ON e.EventID = r.EventID
GROUP BY e.EventName;

-- 9. Find which event has the most tickets priced above 2000
SELECT e.EventName, COUNT(t.TicketID) AS ExpensiveTickets
FROM Events e
JOIN Tickets t ON e.EventID = t.EventID
WHERE t.Price > 2000
GROUP BY e.EventName
ORDER BY ExpensiveTickets DESC
LIMIT 1;

-- 10. Show events happening in October 2025
SELECT EventName, EventDate
FROM Events
WHERE MONTH(EventDate) = 10 AND YEAR(EventDate) = 2025;

-- 1. List all performers for Music Festival
SELECT e.EventName, p.Name AS Performer, p.Genre, ep.Role
FROM EventPerformers ep
JOIN Events e ON ep.EventID = e.EventID
JOIN Performers p ON ep.PerformerID = p.PerformerID
WHERE e.EventName = 'Music Festival';

-- 2. Find all events where 'A. R. Rahman' is performing
SELECT e.EventName, e.EventDate, v.VenueName
FROM EventPerformers ep
JOIN Performers p ON ep.PerformerID = p.PerformerID
JOIN Events e ON ep.EventID = e.EventID
JOIN Venues v ON e.VenueID = v.VenueID
WHERE p.Name = 'A. R. Rahman';

-- 3. Show headliners for each event
SELECT e.EventName, p.Name AS Headliner
FROM EventPerformers ep
JOIN Events e ON ep.EventID = e.EventID
JOIN Performers p ON ep.PerformerID = p.PerformerID
WHERE ep.Role = 'Headliner';

SELECT sp.Name, COUNT(es.EventID) AS EventsParticipated
FROM Speakers sp
JOIN EventSpeakers es ON sp.SpeakerID = es.SpeakerID
GROUP BY sp.SpeakerID, sp.Name;

SELECT DISTINCT p.Name, p.Genre
FROM Performers p
JOIN EventPerformers ep ON p.PerformerID = ep.PerformerID
JOIN Events e ON ep.EventID = e.EventID
JOIN Venues v ON e.VenueID = v.VenueID
WHERE v.Capacity > 400;

SELECT e.EventName, AVG(t.Price) AS AvgTicketPrice
FROM Events e
JOIN Tickets t ON e.EventID = t.EventID
GROUP BY e.EventName;

SELECT e.EventName, e.EventDate
FROM Events e
LEFT JOIN EventSponsors es ON e.EventID = es.EventID
WHERE es.SponsorID IS NULL;

SELECT Name, Contribution, ContactInfo
FROM Sponsors
WHERE Contribution > 300000;

