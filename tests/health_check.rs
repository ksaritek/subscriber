mod utils;
use utils::spawn_app;

#[tokio::test]
async fn health_check() {
    // Arrange
    let test_app = spawn_app().await.expect("Failed to spawn app.");
    let client = reqwest::Client::new();

    // Act
    let response = client
        .get(format!("{}/health_check", test_app.address))
        .send()
        .await
        .expect("Failed to send request.");

    // Assert
    assert!(response.status().is_success());
    assert_eq!(Some(0), response.content_length());
}
