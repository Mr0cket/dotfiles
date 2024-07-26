#!/usr/bin/env python

from openai import Client
import os, sys, json

args = sys.argv[1:]
HOME_PATH = os.environ['HOME']
with open(f"{HOME_PATH}/.openai_api_key") as f:
    client = Client(api_key=f.read().strip())


def save_history(history):
    with open(f"{HOME_PATH}/.openai_chat_history", "w") as f:
        json.dump(history, f)


def load_history():
    try:
        with open(f"{HOME_PATH}/.openai_chat_history") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):  # create the file
        with open(f"{HOME_PATH}/.openai_chat_history", 'w+') as f:
            return {}


# parse & strip specific flags/env_vars
CHAT_HISTORY = load_history()
if args[0] == "-r":
    print('Resetting conversation\n--------------------------\n\n')
    args = args[1:]
    CHAT_HISTORY = {}

# gpt4 flag


msg = " ".join(sys.argv[1:])
system_msg = {
    "role": "system",
    "content": "You are chatGPT a large language model from OpenAI. Answer as concisely as possible",
}

templates = {
    "howto": [
        system_msg,
        {
            "role": "user",
            "content": f"Answer with only the actual command without intro or explanation. What is the ubuntu command line command to {msg}",
        },
    ],
    "why": [
        system_msg,
        {
            "role": "user",
            "content": f"Answer with a simple and concise explanation, why {msg}",
        },
    ],
    "explain": [
        system_msg,
        {
            "role": "user",
            "content": f"Answer with a simple and concise explanation, {msg}",
        },
    ],
    "reword": [
        system_msg,
        {
            "role": "user",
            "content": f"Reword in the tone of a proper British gentleman from the 1950s (for example, Winston Churchill), keeping language understandable by contemporary audiences: \n\n{msg}",
        },
    ],
    "iamrole": [
        {
            "role": "system",
            "content": "Answer only with the actual GCP IAM role id in the format 'roles/xx.xxx', for example, if the input is 'Cloudrun admin', your answer should be 'roles/run.admin'.",
        },
        {
            "role": "user",
            "content": f"What is the GCP IAM role id for: \n\n{msg}",
        },
    ],
}

cmd = os.path.basename(sys.argv[0])
if not cmd in templates:
    print("Command '{cmd}' not supported.\n Choose one of:", ", ".join(templates.keys()), file=sys.stderr)
    exit(1)

# Check if there have been previous conversations
conv = CHAT_HISTORY.get(cmd, [])
if not conv:
    conv: list[dict[str, str]] | None = templates[cmd]
else:
    conv.append({"role": "user", "content": msg})


r = client.chat.completions.create(
    # model="gpt-3.5-turbo",
    # model="gpt-4",
    model="gpt-4o",
    messages=conv,
    temperature=0.5,
    n=1,
)
response = r.choices[0].message.content
print(response)

conv.append({"role": "assistant", "content": response})
CHAT_HISTORY[cmd] = conv
save_history(CHAT_HISTORY)
