//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './SVG.sol';
import './Utils.sol';

contract Renderer {
    function render(uint256 _tokenId) public pure returns (string memory) {
        uint256 pin = 3333;
        return
            string.concat(
                '<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" style="background:#000000">',
                string.concat(
                    '<defs><linearGradient id="f" x1=".5" x2=".5" y2="1"><stop stop-color="#ffffb5" offset="0"/><stop stop-color="#fef372" offset=".0733"/><stop stop-color="#f6d860" offset=".22"/><stop stop-color="#f3bf59" offset=".2767"/><stop stop-color="#ed894b" offset=".39"/><stop stop-color="#e47346" offset=".45"/><stop stop-color="#d53a42" offset=".57"/><stop stop-color="#c93a51" offset=".6333"/><stop stop-color="#b1385e" offset=".76"/><stop stop-color="#97385d" offset=".82"/><stop stop-color="#6a324f" offset=".94"/></linearGradient><radialGradient id="s" gradientTransform="translate(-1 -.5) scale(2)"><stop stop-color="#d53a42" offset=".19"/><stop stop-color="rgba(204, 58, 78, 0.75)" offset=".3925"/><stop stop-color="rgba(194, 57, 86, 0.5)" offset=".595"/><stop stop-color="rgba(177, 56, 94, 0)" offset="1"/></radialGradient></defs>'
                ),
                svg.rect(
                    string.concat(
                        svg.prop('fill', 'url(#f)'),
                        svg.prop('x', '10'),
                        svg.prop('y', '10'),
                        svg.prop('width', '980'),
                        svg.prop('height', '980'),
                        svg.prop('rx', '15')
                    ),
                    utils.NULL
                ),
                 svg.rect(
                    string.concat(
                        svg.prop('fill', 'url(#s)'),
                        svg.prop('x', '10'),
                        svg.prop('y', '10'),
                        svg.prop('width', '980'),
                        svg.prop('height', '980'),
                        svg.prop('rx', '15')
                    ),
                    utils.NULL
                ),
                svg.rect(
                    string.concat(
                        svg.prop('fill', 'transparent'),
                        svg.prop('x', '10'),
                        svg.prop('y', '900'),
                        svg.prop('width', '980'),
                        svg.prop('height', '600'),
                        svg.prop('rx', '15')
                    ),
                    utils.NULL
                ),
                svg.text(
                    string.concat(
                        svg.prop('x', '20'),
                        svg.prop('y', '40'),
                        svg.prop('font-size', '22'),
                        svg.prop('fill', 'white')
                    ),
                    string.concat(
                        svg.cdata('Hello, tokensss #'),
                        utils.uint2str(_tokenId)
                    )
                ),
                 string.concat(' <path id="path" d="M30 30 L970 30 L970 970 L30 970Z" fill="transparent"/><text text-anchor="middle"><textPath font-size="25px" class="my-text" href="#path" startOffset="0%"><animate attributeName="startOffset" from="0%" to="100%" dur="20s" repeatCount="indefinite"></animate>',
                 '0x47457547854367543785468754684537654387' //address of owner
                 ,'</textPath></text>'),
                '</svg>'
            );
    }

    function example() external pure returns (string memory) {
        return render(1);
    }
}
