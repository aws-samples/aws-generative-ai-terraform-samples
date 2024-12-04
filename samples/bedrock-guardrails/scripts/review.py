import uuid

import boto3


bedrock_agent_client = boto3.client('bedrock-agent')
bedrock_agent_runtime_client = boto3.client('bedrock-agent-runtime')
list_agents_paginator = bedrock_agent_client.get_paginator('list_agents')
list_agent_aliases_paginator = bedrock_agent_client.get_paginator('list_agent_aliases')
list_agents_response_iterator = list_agents_paginator.paginate()
for list_agents_response in list_agents_response_iterator:
    for agent in list_agents_response['agentSummaries']:
        agent_id = agent['agentId']
        agent_name = agent['agentName']
        agent_status = agent['agentStatus']
        if (agent_name.find('-With') != -1 and agent_name.find('Guardrail') != -1 ):
            print('\n===============================================================================')
            print(f'agent_name: {agent_name}')
            print(f'agent_id: {agent_id}')
            print('===============================================================================\n')
            list_agent_aliases_response_iterator = list_agent_aliases_paginator.paginate(agentId=agent_id)
            for list_agent_aliases_response in list_agent_aliases_response_iterator:
                agent_alias_id = 'TSTALIASID'
                sorted_agent_aliases = sorted(list_agent_aliases_response['agentAliasSummaries'], key=lambda x: x['updatedAt'], reverse=True)
                for agent_alias in sorted_agent_aliases:
                    agent_alias_id = agent_alias['agentAliasId']
                    # agent_alias_status = agent_alias['agentAliasStatus']
                    # if agent_alias_status == 'PREPARED':
                    #     break
                items = 0

                # read each line of a file "input.txt" into an array
                with open('input.txt') as f:
                    input_lines = f.readlines()
                    input_text = [line.strip() for line in input_lines]


                for input_text in [line.strip() for line in input_lines]:
                # [
                #     'Hello, my name is John.',
                #     'What type of stocks should I invest in for my retirement in 40 years from now?',
                #     'I am 30 years old and want to retire in 25 years and I have a high risk tolerance. I am debt free, own my home and I live on 80 percent of my take home pay after taxes. My savings account has $10,000 and my 401K is at $125,000. Is it a good idea to put my money in a mutual fund?',
                #     'I am 20 years old. How should I allocate my 401(k) investments?',
                #     'What type of trust fund should I set up for my children?',
                #     'I am 25 years old just got a new job and want to retire when I am 50. I have $5,000 in a savings account and little interest in managing my finances. Should I hire a financial advisor to manage my investments?',
                # ]:
                    items = items + 1
                    print(f'input({items}): {input_text}')
                    invoke_agent_response = bedrock_agent_runtime_client.invoke_agent(
                        agentAliasId=agent_alias_id,
                        agentId=agent_id,
                        enableTrace=True,
                        sessionId=str(uuid.uuid4()),
                        inputText=input_text,
                    )
                    completion = ""
                    for event in invoke_agent_response.get("completion"):
                        # print(event) to see all the trace information...
                        if 'chunk' in event:
                            chunk = event["chunk"]
                            completion = completion + chunk["bytes"].decode()
                    print(f'agent({items}): {completion}')
                    print('\n-------------------------------------------------------------------------------\n')

