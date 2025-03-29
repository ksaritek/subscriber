use std::net::TcpListener;
use subscriber::startup;
use sqlx::{PgConnection, Connection};
use subscriber::configuration::get_configuration;


pub async fn spawn_app() -> Result<String, std::io::Error> {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Failed to bind random port");
    let port = listener.local_addr().unwrap().port();
    let config = get_configuration().expect("Failed to read configuration.");
    let connection = PgConnection::connect(&config.database.connection_string())
        .await
        .expect("Failed to connect to Postgres.");
    
    let server = startup::run(listener, connection).expect("Failed to bind address");
    let _ = tokio::spawn(server);

    Ok(format!("http://localhost:{}", port))
}
