//SPDX-License-Identifier: MIT

// this is a modification of original uniswap v3 nft design
pragma solidity ^0.8.11;

import '@openzeppelin/contracts/utils/Strings.sol';
import 'base64-sol/base64.sol';

// import './SVG.sol';
// import './Utils.sol';

contract Renderer {
    using Strings for uint256;

    struct SVGParams {
        uint256 tokenId;
        string color0;
        string color1;
        string color2;
        string color3;
        string bordertext;
        string title;
        string subtitle;
        string attribute1;
        string attribute2;
        string attribute3;
    }

    function render(uint256 _tokenId) public pure returns (string memory) {
        // don't forget to query team
        uint256 team = 1;
        string memory house = 'Mileah Castle';

        string memory color1 = 'CC5500';
        string memory color2 = 'CC5500';
        string memory color3 = 'CC5500';
        string memory color4 = 'CC5500';

        if (team == 0) {
            color1 = '0096FF';
        } else {
            house = 'Hahyrst Tower';
            color1 = 'CC5500';
        }

        return
            generateSVG(
                SVGParams(
                    _tokenId,
                    color1,
                    color2,
                    color3,
                    color4,
                    'XP: 0', //border text
                    'ENEAS', //title
                    'Mystery', //subtitle
                    _tokenId.toString(), //attr1
                    house, //attr 2
                    '0' //attr3
                )
            );
    }

    function generateSVG(SVGParams memory params)
        internal
        pure
        returns (string memory svg)
    {
        /*
        address: "0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        msg: "Forged in SVG for Uniswap in 2021 by 0xe8ab59d3bcde16a29912de83a90eb39628cfc163",
        sig: "0x2df0e99d9cbfec33a705d83f75666d98b22dea7c1af412c584f7d626d83f02875993df740dc87563b9c73378f8462426da572d7989de88079a382ad96c57b68d1b",
        version: "2"
        */
        return
            string(
                abi.encodePacked(
                    generateSVGDefs(params),
                    generateSVGBorderText(params.bordertext),
                    generateSVGCardMantle(params.title, params.subtitle),
                    generateMiddleImage(),
                    generateSVGLeftData(
                        params.attribute1,
                        params.attribute2,
                        params.attribute3
                    ),
                    '</svg>'
                )
            );
    }

    function generateSVGDefs(SVGParams memory params)
        private
        pure
        returns (string memory svg)
    {
        svg = string(
            abi.encodePacked(
                '<svg width="290" height="500" viewBox="0 0 290 500" xmlns="http://www.w3.org/2000/svg"',
                " xmlns:xlink='http://www.w3.org/1999/xlink'>",
                '<defs>',
                '<filter id="f1"><feImage result="p0" xlink:href="data:image/svg+xml;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><rect width='290px' height='500px' fill='#",
                            params.color0,
                            "'/></svg>"
                        )
                    )
                ),
                '"/><feImage result="p1" xlink:href="data:image/svg+xml;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            '1',
                            "' cy='",
                            '1',
                            "' r='120px' fill='#",
                            params.color1,
                            "'/></svg>"
                        )
                    )
                ),
                '"/><feImage result="p2" xlink:href="data:image/svg+xml;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            '1',
                            "' cy='",
                            '1',
                            "' r='120px' fill='#",
                            params.color2,
                            "'/></svg>"
                        )
                    )
                ),
                '" />',
                '<feImage result="p3" xlink:href="data:image/svg+xml;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "<svg width='290' height='500' viewBox='0 0 290 500' xmlns='http://www.w3.org/2000/svg'><circle cx='",
                            '1',
                            "' cy='",
                            '1',
                            "' r='100px' fill='#",
                            params.color3,
                            "'/></svg>"
                        )
                    )
                ),
                '" /><feBlend mode="overlay" in="p0" in2="p1" /><feBlend mode="exclusion" in2="p2" /><feBlend mode="overlay" in2="p3" result="blendOut" /><feGaussianBlur ',
                'in="blendOut" stdDeviation="42" /></filter> <clipPath id="corners"><rect width="290" height="500" rx="42" ry="42" /></clipPath>',
                '<path id="text-path-a" d="M40 12 H250 A28 28 0 0 1 278 40 V460 A28 28 0 0 1 250 488 H40 A28 28 0 0 1 12 460 V40 A28 28 0 0 1 40 12 z" />',
                '<path id="minimap" d="M234 444C234 457.949 242.21 463 253 463" />',
                '<filter id="top-region-blur"><feGaussianBlur in="SourceGraphic" stdDeviation="24" /></filter>',
                '<linearGradient id="grad-up" x1="1" x2="0" y1="1" y2="0"><stop offset="0.0" stop-color="white" stop-opacity="1" />',
                '<stop offset=".9" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<linearGradient id="grad-down" x1="0" x2="1" y1="0" y2="1"><stop offset="0.0" stop-color="white" stop-opacity="1" /><stop offset="0.9" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<mask id="fade-up" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="url(#grad-up)" /></mask>',
                '<mask id="fade-down" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="url(#grad-down)" /></mask>',
                '<mask id="none" maskContentUnits="objectBoundingBox"><rect width="1" height="1" fill="white" /></mask>',
                '<linearGradient id="grad-symbol"><stop offset="0.7" stop-color="white" stop-opacity="1" /><stop offset=".95" stop-color="white" stop-opacity="0" /></linearGradient>',
                '<mask id="fade-symbol" maskContentUnits="userSpaceOnUse"><rect width="290px" height="200px" fill="url(#grad-symbol)" /></mask></defs>',
                '<g clip-path="url(#corners)">',
                '<rect fill="',
                params.color0,
                '" x="0px" y="0px" width="290px" height="500px" />',
                '<rect style="filter: url(#f1)" x="0px" y="0px" width="290px" height="500px" />',
                ' <g style="filter:url(#top-region-blur); transform:scale(1.5); transform-origin:center top;">',
                '<rect fill="none" x="0px" y="0px" width="290px" height="500px" />',
                '<ellipse cx="50%" cy="0px" rx="180px" ry="120px" fill="#000" opacity="0.85" /></g>',
                '<rect x="0" y="0" width="290" height="500" rx="42" ry="42" fill="rgba(0,0,0,0)" stroke="rgba(255,255,255,0.2)" /></g>'
            )
        );
    }

    function generateSVGBorderText(string memory text)
        private
        pure
        returns (string memory svg)
    {
        svg = string(
            abi.encodePacked(
                '<text text-rendering="optimizeSpeed">',
                '<textPath startOffset="-100%" fill="white" font-family="\'Verdana\', monospace" font-size="10px" xlink:href="#text-path-a">',
                text,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" />',
                '</textPath> <textPath startOffset="0%" fill="white" font-family="\'Verdana\', monospace" font-size="10px" xlink:href="#text-path-a">',
                text,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /> </textPath>',
                '<textPath startOffset="50%" fill="white" font-family="\'Verdana\', monospace" font-size="10px" xlink:href="#text-path-a">',
                text,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s"',
                ' repeatCount="indefinite" /></textPath><textPath startOffset="-50%" fill="white" font-family="\'Verdana\', monospace" font-size="10px" xlink:href="#text-path-a">',
                text,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /></textPath></text>'
            )
        );
    }

    function generateSVGCardMantle(string memory title, string memory subtitle)
        private
        pure
        returns (string memory svg)
    {
        svg = string(
            abi.encodePacked(
                '<g mask="url(#fade-symbol)"><rect fill="none" x="0px" y="0px" width="290px" height="200px" /> <text y="70px" x="32px" fill="white" font-family="\'Verdana\', monospace" font-weight="200" font-size="36px">',
                title,
                '</text><text y="115px" x="32px" fill="white" font-family="\'Verdana\', monospace" font-weight="200" font-size="36px">',
                subtitle,
                '</text></g>',
                '<rect x="16" y="16" width="258" height="468" rx="26" ry="26" fill="rgba(0,0,0,0)" stroke="rgba(255,255,255,0.2)" />'
            )
        );
    }

    function generateMiddleImage() private pure returns (string memory svg) {
        string memory fade = '#none';

        string memory curve = 'M1 1C41 41 105 105 145 145';

        svg = string(
            abi.encodePacked(
                '<g mask="url(',
                fade,
                ')"',
                ' style="transform:translate(72px,189px)">'
                '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />'
                '<path d="',
                curve,
                '" stroke="rgba(0,0,0,0.3)" stroke-width="32px" fill="none" stroke-linecap="round" />',
                '</g><g mask="url(',
                fade,
                ')"',
                ' style="transform:translate(72px,189px)">',
                '<rect x="-16px" y="-16px" width="180px" height="180px" fill="none" />',
                '<path d="',
                curve,
                '" stroke="rgba(255,255,255,1)" fill="none" stroke-linecap="round" /></g>'
            )
        );

        svg = renderSword();
    }

    function generateSVGLeftData(
        string memory attribute1,
        string memory attribute2,
        string memory attribute3
    ) private pure returns (string memory svg) {
        uint256 str1length = bytes(attribute1).length + 4;
        uint256 str2length = bytes(attribute2).length + 10;
        uint256 str3length = bytes(attribute3).length + 10;
        svg = string(
            abi.encodePacked(
                ' <g style="transform:translate(29px, 384px)">',
                '<rect width="',
                uint256(7 * (str1length + 4)).toString(),
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Verdana\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">ID: </tspan>',
                attribute1,
                '</text></g>',
                ' <g style="transform:translate(29px, 414px)">',
                '<rect width="',
                uint256(7 * (str2length + 4)).toString(),
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Verdana\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">House: </tspan>',
                attribute2,
                '</text></g>',
                ' <g style="transform:translate(29px, 444px)">',
                '<rect width="',
                uint256(7 * (str3length + 4)).toString(),
                'px" height="26px" rx="8px" ry="8px" fill="rgba(0,0,0,0.6)" />',
                '<text x="12px" y="17px" font-family="\'Verdana\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)">Coins: </tspan>',
                attribute3,
                '</text></g>'
                '<g style="transform:translate(226px, 433px)">',
                '<rect width="36px" height="36px" rx="8px" ry="8px" fill="none" stroke="rgba(255,255,255,0.2)" />',
                '<text x="7px" y="21px" font-family="\'Verdana\', monospace" font-size="12px" fill="white"><tspan fill="rgba(255,255,255,0.6)"> </tspan>',
                '123',
                '</text>',
                // here goes bottom left image
                '</g>'
            )
        );
    }

    function example() external pure returns (string memory) {
        return render(1);
    }

    function renderSword() internal pure returns (string memory sword) {
        sword = string(
            abi.encodePacked(
                '<path transform="translate(40,160) scale(0.45)" d=" M 424.885 16.03 C 424.261 16.14 423.65 16.317 423.063 16.556 L 330.315 47.377 C 328.912 47.831 327.651 48.64 326.654 49.726 L 131.002 263.936 L 89.464 234.946 C 86.183 232.553 81.653 232.886 78.756 235.732 L 57.857 255.828 C 54.619 259.08 54.619 264.337 57.857 267.589 L 94.956 304.68 L 52.106 359.016 C 32.16 359.877 16.06 376.237 16.06 396.383 C 16.06 417.055 33.005 434 53.678 434 C 73.824 434 90.183 417.9 91.036 397.946 L 145.372 355.112 L 182.463 392.203 C 185.714 395.441 190.972 395.441 194.224 392.203 L 214.337 371.304 C 217.157 368.395 217.485 363.882 215.114 360.596 L 186.124 319.058 L 400.334 123.398 C 401.42 122.401 402.23 121.14 402.683 119.736 L 433.512 26.997 C 434.402 24.332 433.883 21.397 432.133 19.198 C 430.408 16.985 427.681 15.793 424.885 16.03 Z  M 412.614 37.455 L 387.268 112.689 L 176.193 305.207 L 164.181 287.97 C 163.621 287.148 162.912 286.44 162.091 285.88 L 144.845 273.867 L 337.379 62.792 L 412.614 37.455 Z  M 85.544 252.434 L 126.037 280.914 C 126.956 281.959 128.126 282.77 129.431 283.255 L 151.382 298.678 L 167.056 321.14 C 167.539 322.237 168.251 323.218 169.146 324.015 L 197.618 364.5 L 188.214 374.431 L 75.621 261.846 L 85.544 252.434 Z  M 106.969 316.701 L 133.351 343.083 L 87.115 379.664 C 83.464 372.454 77.607 366.597 70.396 362.945 L 106.969 316.701 Z  M 53.678 375.484 C 65.297 375.484 74.576 384.763 74.576 396.383 C 74.576 408.002 65.297 417.281 53.678 417.281 C 42.058 417.281 32.779 408.002 32.779 396.383 C 32.779 384.763 42.058 375.484 53.678 375.484 Z " fill="rgba(0,0,0,0.6)"/>'
            )
        );
    }
}

// Mileah Castle: This large walled castle sits at the top of a rocky hill. The female lord of the castle is a woman named Arteshki, and it is inhabited by a large entourage of servants.

// Hahyrst Tower: This large walled castle sits upon the banks of a river, spanned by a drawbridge. It is in disrepair, and totally deserted.
