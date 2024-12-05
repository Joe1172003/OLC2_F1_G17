import {
    Divider,
    Icon,
    List,
    ListItem,
    Stack,
    useDisclosure
} from "@chakra-ui/react";
import { FaFolderOpen } from "react-icons/fa6";
import { FaSave } from "react-icons/fa";
import {useEffect, useRef, useState} from "react";

const Navbar = ({getInput}) => {
    const fileInputRef = useRef(null);

    const { isOpen: isOpenModal1, onOpen: onOpenModal1, onClose: onCloseModal1 } = useDisclosure();
    const [dataT, setDataT] = useState([]);
    const [loading, setLoading] = useState(false);

    const { isOpen: isOpenModal2, onOpen: onOpenModal2, onClose: onCloseModal2 } = useDisclosure();
    const [dataTE, setDataTE] = useState([]);
    const [loadingE, setLoadingE] = useState(false);

    const { isOpen: isOpenModal3, onOpen: onOpenModal3, onClose: onCloseModal3 } = useDisclosure();
    //const [dataTE, setDataTE] = useState([]);
    const [loadingG, setLoadingG] = useState(false);

    const handleFileClick = () => {
        fileInputRef.current.click();
    };

    const typeMap = {
        0: "Int",
        1: "Double",
        2: "Boolean",
        3: "Char",
        4: "String"
    };

    const getSymbolTable = () =>{
        fetch('http://localhost:5000/get-symbols')
            .then((response) => {
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json();
            })
            .then((data) => {
                setDataT(data);
                setLoading(false);
            })
            .catch((error) => {
                console.log(error)
                setLoading(false);
            });
    }

    const getErrorTable = () => {
        fetch('http://localhost:5000/get-errors')
            .then((response) => {
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json();
            })
            .then((data) => {
                setDataTE(data.errors);
                console.log(dataTE)
                setLoadingE(false);
            })
            .catch((error) => {
                console.log(error)
                setLoadingE(false);
            });
    }

    const getGraph = () => {
        fetch('http://localhost:5000/get-graph')
            .then((response) => {
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json();
            })
            .then((data) => {
                //setDataTE(data.errors);
                console.log(dataTE)
                setLoadingG(false);
            })
            .catch((error) => {
                console.log(error)
                setLoadingG(false);
            });
    }

    useEffect(() => {
        if (isOpenModal1) {
            getSymbolTable();
        }
    }, [isOpenModal1]);

    useEffect(() => {
        console.log(isOpenModal2)
        if (isOpenModal2) {
            getErrorTable();
        }
    }, [isOpenModal2]);

    useEffect(()=>{
        if(isOpenModal3){
            getGraph()
        }
    }, [isOpenModal3])

    const showFile = async (event) => {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                const text = e.target.result;
                console.log(text);
                getInput(text)
            };
            reader.readAsText(file);
        }
    };

    return(
        <Stack width='5%' alignItems='start' minH='100vh' px={2} py={5}>
            <List spacing={10}>
                <ListItem cursor={'pointer'}>
                    <Stack direction='row' h='8' alignItems={"center"} role={"group"} onClick={handleFileClick}>
                        <Divider orientation='vertical' borderWidth={2.5}
                                 _groupHover={{borderColor: "white", opacity: 1}} borderColor={'unset'}/>
                        <Icon as={FaFolderOpen} w={8} h={8} _groupHover={{color: "white"}}></Icon>
                        <input
                            type="file"
                            ref={fileInputRef}
                            style={{display: "none"}}
                            onChange={showFile}
                        />
                    </Stack>
                </ListItem>
                <ListItem cursor={'pointer'}>
                    <Stack direction='row' h='8' alignItems={"center"} role={"group"}>
                        <Divider orientation='vertical' borderWidth={2.5} _groupHover={{borderColor: "white", opacity: 1}} borderColor={'unset'}/>
                        <Icon as={FaSave} w={8} h={8} _groupHover={{color: "white"}}></Icon>
                    </Stack>
                </ListItem>
            </List>

        </Stack>
    )
}

export default Navbar;