#!/usr/bin/env python

from openai import Client
import os, sys, json
import argparse

system_msg = {
    "role": "system",
    "content": "Answer as simply and concisely as possible",
}

command_templates = {
    "howto": [
        {"role": "system", "content": "Answer with only the actual command without intro or explanation."},
        {
            "role": "user",
            "content": "What is the macos (or unix if equivalent) command line command to {msg}",
        },
    ],
    "howtolinux": [
        {"role": "system", "content": "Answer with only the actual command without intro or explanation."},
        {
            "role": "user",
            "content": "What is the ubuntu command line command to {msg}",
        },
    ],
    "explain": [
        system_msg,
        {
            "role": "user",
            "content": "Answer with a simple and concise explanation, {msg}",
        },
    ],
    "reword": [
        system_msg,
        {
            "role": "user",
            "content": "Reword in the tone of a proper British gentleman from the 1950s (for example, Winston Churchill), keeping language understandable by contemporary audiences: \n\n{msg}",
        },
    ],
    "iamrole": [
        {
            "role": "system",
            "content": "Answer only with the actual GCP IAM role id in the format 'roles/xx.xxx', for example, if the input is 'Cloudrun admin', your answer should be 'roles/run.admin'.",
        },
        {
            "role": "user",
            "content": "What is the GCP IAM role id for: \n\n{msg}",
        },
    ],
    "synonym": [
        {
            "role": "system",
            "content": "Answer only with a list of synonyms for the word or phrase entered.",
        },
        {"role": "user", "content": "What are common synonyms for: '{msg}'"},
    ],
}


parser = argparse.ArgumentParser()

parser.add_argument('--sync', action='store_true', help='Enable synchronization')
parser.add_argument('-r', '--reset', action='store_true', help='Enable synchronization')
parser.add_argument('-t', '--temperature', type=float, default=0.5)
parser.add_argument('words', nargs='*')

args = parser.parse_args()
# print('DEBUG:', args)

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
            f.write('{}')
            return {}


# parse & strip specific flags/env_vars
CHAT_HISTORY = load_history()
if args.reset:
    print('Resetting conversation\n--------------------------\n\n')
    CHAT_HISTORY = {}

# Create symlinks to all the commands in the $HOME/bin directory.
if args.sync:
    exec_dir = os.path.join(os.environ["HOME"], '.bin')
    print(f'syncing commands to', exec_dir)
    for command_name in command_templates.keys():
        target = os.path.join(exec_dir, command_name)
        # Remove previously symlinks incase the path to the prompts script has changed

        if os.path.islink(target):
            os.unlink(target)
        os.symlink(os.path.abspath(__file__), target)

    # Warn if destination is not in current path:
    if exec_dir not in os.environ['PATH']:
        print(f'WARNING: {exec_dir} not in PATH')
    print('-----------------------------\n')

# TODO: gpt4 flag


if not args.words:
    # Exit program early
    print("No prompt provided")
    sys.exit()

msg = " ".join(args.words)

cmd = os.path.basename(sys.argv[0])
if not cmd in command_templates:
    print(f"Command '{cmd}' not supported.\n Choose one of:", ", ".join(command_templates.keys()), file=sys.stderr)
    exit(1)

# Check if there have been previous conversations
conv = CHAT_HISTORY.get(cmd)
if not conv:
    conv = command_templates[cmd]
    conv[-1]['content'] = conv[-1]['content'].format(msg=msg)
else:
    conv.append({"role": "user", "content": msg})


r = client.chat.completions.create(
    # model="gpt-3.5-turbo",
    # model="gpt-4",
    model="gpt-4o",
    messages=conv,
    temperature=args.temperature,
    n=1,  # How many chat completion choices to generate
)
response = r.choices[0].message.content
print(response)

conv.append({"role": "assistant", "content": response})
CHAT_HISTORY[cmd] = conv
save_history(CHAT_HISTORY)
