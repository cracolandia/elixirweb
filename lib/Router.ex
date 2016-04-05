defmodule Elixirweb.Router do
	defmacro __using__(_options) do
		quote do
			
			def init(options), do: options
			def call(connection, _options) do
				route(connection.method, connection.path_info, connection)
			end

		end
	end
end