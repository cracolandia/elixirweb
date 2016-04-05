defmodule UserController do
	use Elixirweb.Router
	require EEx

	EEx.function_from_file :defp, :template_users, "lib/templates/users/index.eex"
	def route("GET", ["users"], connection) do
		page_contents = template_users
		connection 
		|> Plug.Conn.put_resp_content_type("text/html") 
		|> Plug.Conn.send_resp(200, page_contents)
	end

	EEx.function_from_file :defp, :template_users_id, "lib/templates/users/show.eex", [:id]
	def route("GET", ["users", id], connection) do
		page_contents = template_users_id(id)
		connection
		|> Plug.Conn.put_resp_content_type("text/html")
		|> Plug.Conn.send_resp(200, page_contents)
	end
end

defmodule Book do
	use Elixirweb.Router
	require EEx

	EEx.function_from_file :defp, :template_books, "lib/templates/books/index.eex"
	def route("GET", ["books"], connection) do
		page_contents = template_books
		connection
		|> Plug.Conn.put_resp_content_type("text/html")
		|> Plug.Conn.send_resp(200, page_contents)
	end

	EEx.function_from_file :defp, :template_books_id, "lib/templates/books/show.eex", [:id]
	def route("GET", ["books", id], connection) do
		page_contents = template_books_id(id)

		connection
		|> Plug.Conn.put_resp_content_type("text/html")
		|> Plug.Conn.send_resp(200, page_contents)
	end
end

defmodule Elixirweb do
	use Elixirweb.Router

	def route("GET", ["/"], connection) do
		connection
		|> Plug.Conn.send_resp(200, "Home")
	end

	@user_options UserController.init([])
	def route("GET", ["users" | path], connection) do
		UserController.call connection, @user_options
	end

	@book_options Book.init([])
	def route("GET", ["books" | path], connection) do
		Book.call connection, @book_options
	end

	def route(_method, _path, connection) do
		connection
		|> Plug.Conn.send_resp(404, "Not found!")
	end
end

Plug.Adapters.Cowboy.http Elixirweb, [], port: 8080
IO.puts "Running Plug with cowboy localhost port 8080"