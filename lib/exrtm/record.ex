
defmodule Exrtm.Record do
  defrecord Chunk, id: nil, completed: nil, added: nil, postponed: nil,
                   priority: nil, deleted: nil, has_due_time: nil,
                   estimate: nil, due: nil

  defrecord Task, id: nil, name: nil, tags: nil, modified: nil, participants: nil,
                  url: nil, created: nil, source: nil, rrule: nil,
                  chunks: nil, list_id: nil

  defrecord List, id: nil, name: nil, deleted: nil, locked: nil,
                  archived: nil, position: nil, smart: nil, sort_order: nil

end

