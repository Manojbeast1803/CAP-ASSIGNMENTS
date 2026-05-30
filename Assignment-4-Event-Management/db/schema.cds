namespace platform.events;

// Reusable Types
type Email  : String(100);
type Phone  : String(20);
type Amount : Decimal(10,2);
type Rating : Decimal(2,1);
type Name   : String(100);
type URL    : String(255);

// Enums
type EventType : String enum {
    Conference;
    Workshop;
    Seminar;
    Webinar;
    Meetup;
}

type EventStatus : String enum {
    Draft;
    Published;
    Ongoing;
    Completed;
    Cancelled;
}

type TicketType : String enum {
    General;
    VIP;
    Student;
}

type RegistrationStatus : String enum {
    Confirmed;
    Cancelled;
    Waitlisted;
    Attended;
}

type VenueType : String enum {
    Auditorium;
    ConferenceHall;
    Outdoor;
    Virtual;
}

//Entities
entity Venues {
    key ID         : UUID;
    name           : Name;
    address        : String(255);
    city           : String(50);
    capacity       : Integer;
    type           : VenueType;
    amenities      : String(255);
    hourlyRate     : Amount;
    contactPerson  : Name;
    phone          : Phone;
    isActive       : Boolean;
}

entity Events {
    key ID            : UUID;
    title             : String(150);
    description       : String(500);
    eventType         : EventType;
    venueId           : String(50);

    startDate         : Date;
    endDate           : Date;
    startTime         : Time;
    endTime           : Time;

    maxAttendees      : Integer;
    registeredCount   : Integer default 0;

    ticketPrice       : Amount;
    status            : EventStatus default 'Draft';

    organizerName     : Name;
    organizerEmail    : Email;
    tags              : String(255);
}

entity Speakers {
    key ID        : UUID;
    name          : Name;
    email         : Email;
    phone         : Phone;
    bio           : String(500);
    company       : String(100);
    designation   : String(100);
    expertise     : String(255);
    photoUrl      : URL;
    rating        : Rating;
    totalTalks    : Integer;
    isActive      : Boolean;
}

entity EventSpeakers {
    key eventId       : String(50);
    key speakerId     : String(50);

    topic             : String(150);
    sessionTime       : Time;
    sessionDuration   : Integer;
    roomNumber        : String(20);
}

entity Registrations {
    key ID                 : UUID;

    eventId                : String(50);

    attendeeName           : Name;
    attendeeEmail          : Email;
    attendeePhone          : Phone;

    company                : String(100);

    ticketType             : TicketType;

    registrationDate       : Date;

    status                 : RegistrationStatus default 'Confirmed';

    amountPaid             : Amount;

    paymentId              : String(50);
}

entity Feedback {
    key ID             : UUID;

    eventId            : String(50);

    attendeeEmail      : Email;

    overallRating      : Rating;
    contentRating      : Rating;
    venueRating        : Rating;
    speakerRating      : Rating;

    comment            : String(500);

    submittedAt        : DateTime;
}

