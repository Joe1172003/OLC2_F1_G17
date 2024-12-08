import {Box, Text, Button, useToast, Icon} from "@chakra-ui/react";
import {useEffect, useState} from "react";
import parseInput from "../../analyzer/grammar";

const Output = ({editorRef, outputRef, getOutput}) => {
    const toast = useToast();
    const [output, setOutput] = useState(outputRef);
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        setOutput(outputRef);
    }, [outputRef]);

    const execute_parser = () => {
        const result_parser = parseInput(editorRef.getValue())
        setOutput(result_parser)
        getOutput(result_parser)
    }

    const add_break = (output, number)=>{
        let result = "";
        for (let i = 0; i < output.length; i += number) {
            result += output.slice(i, i + number) + "\n";
        }
        return result;
    }

    return (
        <Box w="40%" py={5}>
            <Text mb={2} fontSize='lg'>Analize</Text>
            <Button
                variant='outline'
                mb={4}
                isLoading={isLoading}
                borderColor={'rgba(99,179,237,1)'}
                color={'rgba(99,179,237,1)'}
                onClick={execute_parser}
            >
                Analize Code
            </Button>
            <Box
                height='85vh'
                p={2}
                border='1px solid'
                borderRadius={4}
                borderColor='#333'
                overflow={'auto'}
            >
                <pre>
                    {output && output.length > 0
                        ? <Text color={output[1] == 'error' ? 'red' : '#73ed3a'} fontWeight={'semibold'} fontStyle={'italic'}>{add_break(output[0], 60)}</Text>
                        : 'Click "Analize Code" to see the result'}
                </pre>    
            </Box>
        </Box>
    );
};



export default Output;
