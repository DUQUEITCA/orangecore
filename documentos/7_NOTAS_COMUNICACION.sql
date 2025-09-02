CREATE SCHEMA IF NOT EXISTS notas_comunicacion;
SET search_path TO notas_comunicacion;


-- TABLA 243: NOTES
-- Tabla principal que almacena las notas y soporta el threading (respuestas anidadas)[cite: 1].
CREATE TABLE notas_comunicacion.notes (
    id SERIAL PRIMARY KEY,
    parent_note_id INTEGER,
    note_type VARCHAR(30) NOT NULL,
    context_id INTEGER,
    context_table VARCHAR(50) NOT NULL,
    note_content TEXT NOT NULL,
    created_by_contact_id INTEGER NOT NULL,
    is_private BOOLEAN DEFAULT FALSE,
    has_replies BOOLEAN DEFAULT FALSE,
    signalr_group_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_notes_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Se agrega la llave foranea auto-referenciada una vez que la tabla existe[cite: 1].
ALTER TABLE notas_comunicacion.notes ADD CONSTRAINT fk_notes_parent FOREIGN KEY (parent_note_id) REFERENCES notas_comunicacion.notes(id);

-- TABLA 244: NOTE_ATTACHMENTS
-- Almacena los archivos adjuntos a las notas[cite: 1].
-- Depende de la tabla 'documents' del mdulo 'DOCUMENTOS Y FILE MANAGEMENT'[cite: 1].
CREATE TABLE notas_comunicacion.note_attachments (
    id SERIAL PRIMARY KEY,
    note_id INTEGER NOT NULL,
    document_id INTEGER NOT NULL,
    attachment_type VARCHAR(20) NOT NULL,
    attached_by_contact_id INTEGER,
    attached_at TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(note_id, document_id),
    CONSTRAINT fk_note_attachments_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id),
    CONSTRAINT fk_note_attachments_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id),
    CONSTRAINT fk_note_attachments_attacher FOREIGN KEY (attached_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- TABLA 245: NOTE_TAGS
-- Permite etiquetar notas para bsqueda avanzada y categorizacin[cite: 1].
CREATE TABLE notas_comunicacion.note_tags (
    id SERIAL PRIMARY KEY,
    note_id INTEGER NOT NULL,
    tag_name VARCHAR(50) NOT NULL,
    tag_category VARCHAR(30),
    tag_color VARCHAR(7),
    created_by_contact_id INTEGER,
    is_system_tag BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(note_id, tag_name),
    CONSTRAINT fk_note_tags_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id),
    CONSTRAINT fk_note_tags_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- TABLA 246: NOTE_MENTIONS
-- Registra las menciones (@) a usuarios en las notas para notificaciones[cite: 1].
CREATE TABLE notas_comunicacion.note_mentions (
    id SERIAL PRIMARY KEY,
    note_id INTEGER NOT NULL,
    mentioned_contact_id INTEGER NOT NULL,
    mentioned_at TIMESTAMP DEFAULT NOW(),
    is_notified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(note_id, mentioned_contact_id),
    CONSTRAINT fk_note_mentions_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id),
    CONSTRAINT fk_note_mentions_contact FOREIGN KEY (mentioned_contact_id) REFERENCES base_foundation.contacts(id)
);

-- TABLA 247: NOTE_REACTIONS
-- Permite a los usuarios reaccionar a las notas, como con un "like"[cite: 1].
CREATE TABLE notas_comunicacion.note_reactions (
    id SERIAL PRIMARY KEY,
    note_id INTEGER NOT NULL,
    reaction_type VARCHAR(20) NOT NULL,
    reacted_by_contact_id INTEGER NOT NULL,
    reacted_at TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(note_id, reacted_by_contact_id),
    CONSTRAINT fk_note_reactions_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id),
    CONSTRAINT fk_note_reactions_reactor FOREIGN KEY (reacted_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- TABLA 248: NOTE_NOTIFICATIONS
-- Gestiona las notificaciones de notas para los destinatarios[cite: 1].
CREATE TABLE notas_comunicacion.note_notifications (
    id SERIAL PRIMARY KEY,
    note_id INTEGER NOT NULL,
    recipient_contact_id INTEGER NOT NULL,
    notification_type VARCHAR(30) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    signalr_connection_id VARCHAR(100),
    read_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_note_notifications_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id),
    CONSTRAINT fk_note_notifications_recipient FOREIGN KEY (recipient_contact_id) REFERENCES base_foundation.contacts(id)
);