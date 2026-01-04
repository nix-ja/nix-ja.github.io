{ rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage {
  name = "toml-to-ical";
  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "calendar-generation";
    rev = "9bf0ccb9a892094fa232843a31b9c7a441645ffb";
    sha256 = "sha256-UYq5Nsg6JdFw5yhKnSCW5diaweYbGvkCnIuY98wjxvo=";
  };
  cargoHash = "sha256-eg1IgW8f8iwryh1EvqnWOmehoJ1aAxuYJRbTgUE/zZ8=";
}
