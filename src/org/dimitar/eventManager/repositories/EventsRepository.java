package org.dimitar.eventManager.repositories;

import org.dimitar.eventManager.models.Event;

public class EventsRepository extends BaseRepository<Event> {
	public EventsRepository() {
		super(Event.class);
	}
}
