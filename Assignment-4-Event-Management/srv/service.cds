using platform.events as ev from '../db/schema';

service EventService {

    entity Venues         as projection on ev.Venues;
    entity Events         as projection on ev.Events;
    entity Speakers       as projection on ev.Speakers;
    entity EventSpeakers  as projection on ev.EventSpeakers;
    entity Registrations  as projection on ev.Registrations;
    entity Feedback       as projection on ev.Feedback;

}