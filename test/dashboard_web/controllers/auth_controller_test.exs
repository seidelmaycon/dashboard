defmodule DashboardWeb.AuthControllerTest do
  use DashboardWeb.ConnCase

  @ueberauth_auth %{
    uid: "12345",
    info: %{name: "John Doe", urls: %{avatar_url: "https://image.png"}},
    provider: :github
  }

  test "GET /auth/github", %{conn: conn} do
    conn = get(conn, "/auth/github")
    assert redirected_to(conn, 302)
  end

  test "GET /auth/github/callback", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
    |> get("/auth/google/callback")

    assert get_flash(conn, :info) == "Successfully authenticated."
  end

  test "POST /auth/logout", %{conn: conn} do
    conn = post(conn, "/auth/logout")

    assert get_flash(conn, :info) == "You have been logged out!"
    assert redirected_to(conn, 302)
  end
end
