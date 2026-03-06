package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// TrackingEvent holds the schema definition for the TrackingEvent entity.
type TrackingEvent struct {
	ent.Schema
}

// Fields of the TrackingEvent.
func (TrackingEvent) Fields() []ent.Field {
	return []ent.Field{
		field.Time("event_time").Default(time.Now).Immutable(),
		field.String("location").Optional(), // Optional = Não tem NOT NULL

		field.Enum("status").
			Values("PENDING", "IN_TRANSIT", "DELIVERED", "RETURNED"),
	}
}

// Edges of the TrackingEvent.
func (TrackingEvent) Edges() []ent.Edge {
	return []ent.Edge{
		// Um evento pertence a uma única encomenda
		edge.From("package", Parcel.Type).
			Ref("events").
			Unique().
			Required(), // Um evento tem de ter sempre uma encomenda associada
	}
}
