#!/usr/bin/env python

from collections import namedtuple
from litellm import completion

import os, sys, json
import argparse
import litellm

system_msg = "Answer as simply and concisely as possible"
Command = namedtuple('Command', ['system', 'message', 'keep_history'], defaults=['', '', False])


command_templates = {
    "howto": Command(
        system="Answer with only the actual command without intro or explanation.",
        message={
            "role": "user",
            "content": "What is the macos (or unix if equivalent) command line command to {msg}",
        },
    ),
    "howtok8s": Command(
        system="Answer with only the actual command without intro or explanation.",
        message={
            "role": "user",
            "content": "What is the kubernetes command line command to {msg}",
        },
    ),
    "howtolinux": Command(
        system="Answer with only the actual command without intro or explanation.",
        message={
            "role": "user",
            "content": "What is the ubuntu command line command to {msg}",
        },
    ),
    "explain": Command(
        system=system_msg,
        keep_history=True,
        message={
            "role": "user",
            "content": "Answer with a simple and concise explanation, {msg}",
        },
    ),
    "reword": Command(
        system='Rewrite the following message in a friendly casual way. Only rewrite the message. do not respond',
        message={
            "role": "user",
            "content": "{msg}",
        },
    ),
    "rewordBrit": Command(
        system='Reword the message to be more in line with the tone of a proper British gentleman from the 1950s (for example, Winston Churchill), keeping language understandable by modern audiences',
        message={
            "role": "user",
            "content": "{msg}",
        },
    ),
    "iamrole": Command(
        system="Answer only with the actual GCP IAM role id in the format 'roles/xx.xxx', for example, if the input is 'Cloudrun admin', your answer should be 'roles/run.admin'.",
        message={
            "role": "user",
            "content": "What is the GCP IAM role id for: {msg}",
        },
    ),
    "synonym": Command(
        system="Answer only with a list of synonyms for the word or phrase entered.",
        message={"role": "user", "content": "What are common synonyms for: '{msg}'"},
    ),
    "howtodocker": Command(
        system="Answer with only the actual docker command without intro or explanation.",
        message={
            "role": "user",
            "content": "What is the docker command to {msg}",
        },
    ),
}


parser = argparse.ArgumentParser()

parser.add_argument('-m', '--model', type=str, default='anthropic/claude-haiku-4-5-20251001')
parser.add_argument('--sync', action='store_true', help='Synchronise the executable commands')
parser.add_argument('-r', '--reset', action='store_true', help='Reset')
parser.add_argument('-t', '--temperature', type=float, default=0.5)
parser.add_argument('words', nargs='*')

args = parser.parse_args()

HOME_PATH = os.environ['HOME']

# defaults to os.environ.get("ANTHROPIC_API_KEY")

def save_history(history):
    with open(f"{HOME_PATH}/.claude_chat_history", "w") as f:
        json.dump(history, f)


def load_history():
    try:
        with open(f"{HOME_PATH}/.claude_chat_history") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):  # create the file
        with open(f"{HOME_PATH}/.claude_chat_history", 'w+') as f:
            f.write('{}')
        return {}


# parse & strip specific flags/env_vars
CHAT_HISTORY = load_history()
if args.reset:
    print('Resetting conversation\n--------------------------\n\n')
    CHAT_HISTORY = {}
    save_history(CHAT_HISTORY)

# Create symlinks to all the commands in the $HOME/bin directory.
if args.sync:
    exec_dir = os.path.join(os.environ["HOME"], 'bin')
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


if not args.words:
    # Exit program early
    print("No prompt provided")
    sys.exit()

msg = " ".join(args.words)

cmd_name = os.path.basename(sys.argv[0])
if not cmd_name in command_templates:
    print(
        f"Command '{cmd_name}' not supported.\n Choose one of:", ", ".join(command_templates.keys()), file=sys.stderr
    )
    exit(1)

cmd = command_templates[cmd_name]
# Check if there have been previous conversations
conv = CHAT_HISTORY.get(cmd_name)
system_msg = cmd.system
if not conv:
    prompt = cmd.message
    prompt['content'] = prompt['content'].format(msg=msg)
    conv = [prompt]
else:
    conv.append({"role": "user", "content": msg})

response = completion(
    model=args.model,
    system=system_msg,
    messages=conv,
    temperature=args.temperature,
    max_tokens=1024,
)

if len(response.choices) > 1:
    print('WARNING: multiple response messages detected...')

print('[DEBUG] input_tokens:', response.usage.prompt_tokens)
print('[DEBUG] output_tokens:', response.usage.completion_tokens)

response_message = response.choices[0].message['content'].strip()

print(response_message)

conv.append({"role": "assistant", "content": response_message})
if cmd.keep_history:
    CHAT_HISTORY[cmd_name] = conv
    save_history(CHAT_HISTORY)
