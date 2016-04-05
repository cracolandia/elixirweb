defmodule ElixirwebTest do
  @elixirweb_options Elixirweb.init([])

  use ExUnit.Case, async: true
  use Plug.Test

  test 'users' do
  	connection = conn(:get, "/users")
  	connection = Elixirweb.call(connection, @elixirweb_options)

  	assert connection.state == :sent
  	assert connection.status == 200
  end

  test 'user id' do
  	connection = conn(:get, "/users/1")
  	connection = Elixirweb.call(connection, @elixirweb_options)

  	assert connection.state == :sent
  	assert connection.status == 200
  	assert String.match?(connection.resp_body, ~r/User #\d/)
  end

  test 'book index' do
  	connection = conn(:get, "/books")
  	connection = Elixirweb.call(connection, @elixirweb_options)

  	assert connection.state == :sent
  	assert connection.status == 200
  end

  test 'book id' do
  	connection = conn(:get, "/books/1")
  	connection = Elixirweb.call(connection, @elixirweb_options)

  	assert connection.state == :sent
  	assert connection.status == 200
  	assert String.match?(connection.resp_body, ~r/Book #\d/)
  end

  test 'route not found' do
  	connection = conn(:get, "/notfound")
  	connection = Elixirweb.call(connection, @elixirweb_options)

  	assert connection.state == :sent
  	assert connection.status == 404
  	assert String.match?(connection.resp_body, ~r/Not found!/)
  end
end
