import {Box, Text, Button, useToast, Icon} from "@chakra-ui/react";
import {useEffect, useState} from "react";

const Output = ({editorRef, outputRef, getOutput}) => {
    const toast = useToast();
    const [output, setOutput] = useState(outputRef);
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        setOutput(outputRef);
    }, [outputRef]);

    return (
        <Box w="40%" py={5}>
            <Text mb={2} fontSize='lg'>Analize</Text>
            <Button
                variant='outline'
                mb={4}
                isLoading={isLoading}
                borderColor={'rgba(99,179,237,1)'}
                color={'rgba(99,179,237,1)'}
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
                        ? output.map((line, i) => <Text color={'white'} fontWeight={'semibold'} fontStyle={'italic'} key={i}>{line}</Text>)
                        : 'Click "Analize Code" to see the result'}
                </pre>    
            </Box>
        </Box>
    );
};

export default Output;
