use std::collections::HashMap;

use clap::{Parser, Subcommand};
use serde::{Deserialize, Serialize};
use serde_json::from_str;

// struct JiraTicket {
//     id: String,
//     #[serde(default)]  // Use default if field missing
//     name: String,
//     #[serde(default)]
//     email: Option<String>,
//     #[serde(flatten)]  // Capture unknown fields
//     extra: std::collections::HashMap<String, Value>,
// }

#[derive(Debug, Serialize, Deserialize)]
pub struct JiraTicket {
    // id: String,
    // key: String,
    // self_url: String,
    url: String,
    origin: String,
    // #[serde(rename = "fields")]
    // ticket_fields: TicketFields,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct TicketFields {
    summary: String,
    description: Option<String>,
    #[serde(rename = "issuetype")]
    issue_type: IssueType,
    priority: Option<Priority>,
    assignee: Option<User>,
    reporter: User,
    created: String,
    updated: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct IssueType {
    id: String,
    name: String,
    #[serde(rename = "iconUrl")]
    icon_url: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Priority {
    id: String,
    name: String,
    #[serde(rename = "iconUrl")]
    icon_url: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct User {
    #[serde(rename = "accountId")]
    account_id: String,
    #[serde(rename = "emailAddress")]
    email: Option<String>,
    #[serde(rename = "displayName")]
    display_name: String,
    active: bool,
}

#[derive(Parser)]
#[command(version, about, long_about = None, arg_required_else_help = true)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Jira SDK
    Jira {
        /// Override the start time with the format "%H:%M %m/%d/%Y"
        #[arg(short, long)]
        title: String,

        #[arg(short, long, default_value = "")]
        description: String,

        #[arg(short, long)]
        support: Option<bool>,

        #[arg(short, long)]
        infra: Option<bool>,
    },
    ///// Stop a currently active shift
    //Stop {
    //    /// Override the start time with the format "%H:%M %m/%d/%Y"
    //    #[arg(short, long)]
    //    time: Option<String>,
    //},
    //
    ///// Log a task to the active shift
    //Log {
    //    /// Task to be logged
    //    log: Option<String>,
    //
    //    /// Assign a task a time value, in minutes
    //    #[arg(short, long)]
    //    time: Option<String>,
    //},
    //
    //List {
    //    /// Number of shifts to show
    //    #[arg(default_value_t = 3)]
    //    shifts: i64,
    //},
    //
    ///// Import data from a text file, with a custom format
}

fn main() {
    let cli = Cli::parse();

    match &cli.command {
        /*
         * [ ] regular
         * [ ] dev/infra/support
         * [ ] this sprint
         * [ ] backlog
         * [ ] next sprint
         */
        Commands::Jira {
            title,
            description,
            support,
            infra,
        } => {
            let client = reqwest::blocking::Client::new();

            let input = format!(
                r#"
                {{
                    "fields": {{
                        "project": {{
                            "key": "EISD"
                        }},
                        "summary": "{title:?}",
                        "description": "{description:?}",
                        "issuetype": {{
                            "name": ""
                        }}
                    }}
                }}"#
            );
            let res = client
                .post("https://jira.rocketlab.local/rest/api/latest/content/")
                .body(input)
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer <token>")
                .send();

            let body = match res {
                Ok(body) => &body.text(),
                Err(err) => panic!("Error in request: {}", err),
            };
            let parse_result = match body {
                Ok(text) => from_str::<JiraTicket>(text),
                Err(err) => panic!("Could not could not get response text: {}", err),
            };
            let data = match parse_result {
                Ok(data) => data,
                Err(err) => return println!("Could not parse response: {}", err),
            };

            println!("body = {data:?}");
        }
    }
}
