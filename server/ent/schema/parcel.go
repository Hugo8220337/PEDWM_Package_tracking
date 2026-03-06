package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// Parcel holds the schema definition for the Parcel entity.
type Parcel struct {
	ent.Schema
}

// Fields of the Parcel.
func (Parcel) Fields() []ent.Field {
	return []ent.Field{
		field.String("tracking_number").Unique(),

		// O Ent cria o ENUM no Postgres automaticamente!
		field.Enum("status").
			Values("PENDING", "IN_TRANSIT", "DELIVERED", "RETURNED").
			Default("PENDING"),

		field.Time("created_at").Default(time.Now).Immutable(),
		field.Time("updated_at").Default(time.Now).UpdateDefault(time.Now),
	}
}

// Edges of the Parcel.
func (Parcel) Edges() []ent.Edge {
	return []ent.Edge{
		// Uma encomenda tem muitos eventos!
		edge.To("events", TrackingEvent.Type),
	}
}
